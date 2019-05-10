function verify_helm {
  if ! type yq > /dev/null; then
    echo "> helm is not installed locally, aborting"

    exit 11
  fi
}
