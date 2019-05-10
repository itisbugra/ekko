function verify_namespace {
  if [ ! -z "$EKKO_NAMESPACE" ]; then
    echo "> working on a singular namespace \"$EKKO_NAMESPACE\", ignoring entries in properties files"
    echo ">   to disable this behaviour, unset environment variable EKKO_NAMESPACE"
  fi
}
