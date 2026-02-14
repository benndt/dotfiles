alias open-template="DISABLE_AUTO_TITLE='true' tmuxp load -y"
alias p="open-project"

open-project() {
  local project_name

  project_name=$(basename "$PWD")

  if [ "$1" ]; then
    open-template "$1"
    exit 0
  fi

  BASENAME="$project_name" open-template ".generic"
}

projects() {
  local project_name

  project_name=$(find "$DEV" -maxdepth 2 -type d -exec test -e '{}/.git' \; -print | sed -e "s|$DEV/||" | sort | fzf-tmux -p --reverse)

  if [ "$project_name" = "" ]; then
    return
  fi

  cd "$DEV/$project_name" || return

  open-project
}

