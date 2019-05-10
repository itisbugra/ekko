function exit_with_usage {
  cat <<-EOUSAGE
ekko automates the deployment process of your Helm references.

  Basic commands:
  init                        Initializes a new Ekko project.
  install [[PACKAGE]]         Installs a specific release if solution name is given,
                              otherwise installs everything except ones declared in
                              .ekkoignore file.
  purge [[PACKAGE]]           Purges a specific release if solution name is given,
                              otherwise purges everything including the ones declared
                              in .ekkoignore file.
  logs [[PACKAGE]]            Tails the logs of a specific solution.
  version                     Prints the Ekko version.

  Configuration commands:
  configure tls               Configures TLS by registering secrets to the Kubernetes.

usage: ekko [COMMAND...]
EOUSAGE

  exit 9
}
