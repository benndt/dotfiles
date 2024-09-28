open-project() {
  local project_name=$(basename $PWD)

  BASENAME="$project_name" open-template ".generic"
}
