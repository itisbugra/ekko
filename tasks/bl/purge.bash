function delete_solution {
  chart=$(/usr/bin/env yq -r .chart $1)
  release=$(/usr/bin/env yq -r .release $1)
  if [ -z "$EKKO_NAMESPACE" ]; then namespace=$(/usr/bin/env yq -r '.namespace' $1); else namespace=$EKKO_NAMESPACE; fi
  values_file=$(dirname $1)/$(/usr/bin/env yq -r .values $1)
  delete_args=$(/usr/bin/env yq -r '.helm.delete.args // ""' $1)

  echo "> purging $1"
  echo ">   chart: $chart"
  echo ">   release: $release"
  echo ">   values file: $values_file"
  echo ">   running helm delete $delete_args on $1"
  /usr/bin/env helm delete \
    --purge \
    $release \
    $delete_args \
    --debug >> logs

  echo ">   unregistering secrets"
  /usr/bin/env yq -rc '(.secrets // [])[]' $1 \
    | while read line; do
        name=$(echo $line | jq -r '.name')

        /usr/bin/env kubectl delete \
          secret \
          $name \
          --namespace $namespace >> logs
      done

  echo "> purged $solution, some objects might be still in deleting state"
}
