function tail_logs {
  dirname=$(dirname $1)
  solution=`basename $dirname`
  chart=$(/usr/bin/env yq -r .chart $1)
  release=$(/usr/bin/env yq -r .release $1)
  if [ -z "$EKKO_NAMESPACE" ]; then namespace=$(/usr/bin/env yq -r .namespace $1); else namespace=$EKKO_NAMESPACE; fi
  is_json=$(/usr/bin/env yq -r '.logging.json // false' $1)
  container_name=$(kubectl get pods --output=wide --namespace $namespace | grep $solution | awk '{print $1}' | head -n 1)

  echo "> tailing logs for $1"
  echo ">   chart: $chart"
  echo ">   release: $release"

  if [ "$is_json" == "true" ]; then
    /usr/bin/env kubectl \
      logs \
      -f $container_name \
      --namespace $namespace \
      --all-containers=true | jq
  else
    /usr/bin/env kubectl \
      logs \
      -f $container_name \
      --namespace $namespace \
      --all-containers=true
  fi
}
