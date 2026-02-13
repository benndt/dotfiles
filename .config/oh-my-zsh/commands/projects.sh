#!/usr/bin/env bash

projects() {
  local project_name

  project_name=$(find "$DEV" -maxdepth 2 -type d -exec test -e '{}/.git' \; -print | sed -e "s|$DEV/||" | sort | fzf-tmux -p --reverse)

  if [ "$project_name" = "" ]; then
    return
  fi

  cd "$DEV/$project_name" || return

  open-project
}
