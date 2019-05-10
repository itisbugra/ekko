function print_version {
  cat <<-EOVERSION
ekko v0.0.1-alpha with backend (bash interpreter)
$(/bin/bash --version | sed 's/^/   /')
EOVERSION

  exit 0
}
