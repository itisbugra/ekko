function install_solution {
  dirname=$(dirname $1)
  solution=`basename $dirname`
  chart=$(/usr/bin/env yq -r .chart $1)
  release=$(/usr/bin/env yq -r .release $1)
  if [ -z "$EKKO_NAMESPACE" ]; then namespace=$(/usr/bin/env yq -r '.namespace' $1); else namespace=$EKKO_NAMESPACE; fi
  values_file=$dirname/$(/usr/bin/env yq -r .values $1)
  install_args=$(/usr/bin/env yq -r '.helm.install.args // ""' $1)
  before_prerequisites=$(/usr/bin/env yq -r '.tasks.install.before // [] | join("\n")' $1)
  after_prerequisites=$(/usr/bin/env yq -r '.tasks.install.after // [] | join("\n")' $1)

  if grep -q $solution .ekkoignore; then
    echo "> ignoring solution $solution"
  else
    echo "> deploying solution $solution"

    echo ">   registering secrets"
    /usr/bin/env yq -rc '(.secrets // [])[]' $1 \
      | while read line; do
          name=$(echo $line | jq -r '.name')
          file="$dirname/$(echo $line | jq -r '.file')"

          /usr/bin/env kubectl create \
            secret generic \
            $name \
            --from-file $file \
            --namespace $namespace >> logs
        done

    echo ">   instantiating solution requirements"
    echo "$before_prerequisites" \
      | xargs -L1 -I '{}' kubectl apply -f "$dirname/{}.yaml" --namespace $namespace

    echo ">   installing solution"
    echo ">     chart: $chart"
    echo ">     release: $release"
    echo ">     namespace: $namespace"
    echo ">     values file: $values_file"
    echo ">     running helm install $install_args on $1"
    /usr/bin/env helm install \
      --name $release \
      --namespace $namespace \
      --values $values_file \
      $chart \
      $install_args \
      --debug >> logs

    echo ">   finalizing solution requirements"
    echo "$after_prerequisites" \
      | xargs -L1 -I '{}' kubectl apply -f "$dirname/{}.yaml" --namespace $namespace

    echo "> successfully deployed $solution"
  fi
}
