function verify_yq {
  if ! type yq > /dev/null; then
    echo "> yq is not installed locally, installing"
    pip install yq > /dev/null
  fi
}
