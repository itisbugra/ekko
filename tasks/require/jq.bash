function verify_jq {
  if ! type jq > /dev/null; then
    echo "> jq is not installed locally, aborting"

    exit 11
  fi
}
