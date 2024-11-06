open-project() {
  local project_name=$(basename $PWD)

  if [ "$1" ]; then
    open-template "$1"
    exit 0
  fi

  BASENAME="$project_name" open-template ".generic"
}
