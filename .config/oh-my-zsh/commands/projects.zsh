projects() {
  local project_name=$(find $DEV -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | fzf-tmux -p --reverse)

  if [ -z "$project_name" ]; then
    return
  fi

  cd $DEV/$project_name 

  open-project
}
