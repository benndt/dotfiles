#!/usr/bin/env bash

projects() {
  local project_name

  project_name=$(find "$DEV" -maxdepth 1 -mindepth 1 -type d -exec basename {} \; | sort | fzf-tmux -p --reverse)

  if [ "$project_name" = "" ]; then
    return
  fi

  cd "$DEV/$project_name" || return

  open-project
}
