function run_with_args {
  # relic-disable - bash/heredoc-indent #
  if [ $# -eq 0 ]; then
    exit_with_usage
  fi

  if [ $# -eq 1 ]; then
    if [ "$1" == "install" ]; then
      echo "> installing all distributions"

      find . -name properties.yaml | while read each_property_file; do install_solution $each_property_file; done
    elif [ "$1" == "purge" ]; then
      find . -name properties.yaml | while read each_property_file; do delete_solution $each_property_file; done
    elif [ "$1" == "version" ]; then
      print_version
    else
      exit_with_usage
    fi
  elif [ $# -ge 2 ]; then
    property_file=$(find . -name properties.yaml | grep /$2/)

    if [ "$1" == "install" ]; then
      install_solution $property_file
    elif [ "$1" == "purge" ]; then
      delete_solution $property_file
    elif [ "$1" == "logs" ]; then
      tail_logs $property_file
    elif [ "$1" == "init" ]; then
      initialize_project $2
    elif [ "$1" == "configure" ] && [ "$2" == "tls" ]; then
      reset_tls_secret
    else
      exit_with_usage
    fi
  else
    exit_with_usage
  fi
}
