function initialize_project {
  cp -R "$TEMPLATE_PROJECT_RESOURCE_FOLDER_PATH" .
  mv $TEMPLATE_PROJECT_RESOURCE_FOLDER_NAME $1
  /usr/bin/env git -C $1 init >> /dev/null
}
