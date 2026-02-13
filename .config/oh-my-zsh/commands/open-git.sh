#!/usr/bin/env bash

open-git() {
  local ssh_url host https_url

  ssh_url=$(git remote get-url --push origin)
  host=${ssh_url#*@}
  host=${host%:*}

  https_url="https://${host}/${ssh_url#*:}"

  xdg-open "$https_url"
}
