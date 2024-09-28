projects() {
  local project_name=$(find $DEV -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | fzf-tmux -p --reverse)

  cd $DEV/$project_name 

  open-project
}
