function reset_tls_secret {
  if [ -z "$EKKO_NAMESPACE" ]; then namespace=$(/usr/bin/env yq -r '.tls.namespace // "tls"' $MANIFEST_FILE); else namespace=$EKKO_NAMESPACE; fi
  cert="$(/usr/bin/env yq -r '.tls.files.certificate // "./configuration/tls/cert.pem"' $MANIFEST_FILE)"
  key=$(/usr/bin/env yq -r '.tls.files.privateKey // "./configuration/tls/privkey.pem"' $MANIFEST_FILE)

  echo "> removing old tls object (will not pursue if it does not exist)"

  /usr/bin/env kubectl \
    delete secret \
    tls-secret \
    --namespace=$namespace >> logs 2>> /dev/null

  echo "> waiting for kubernetes to settle a bit"

  sleep 3

  echo "> generating tls object"
  echo ">   namespace: $namespace"
  echo ">   certificate file: $cert"

  /usr/bin/env kubectl \
    create secret tls \
    tls-secret \
    --cert=$cert \
    --key=$key >> logs
}
