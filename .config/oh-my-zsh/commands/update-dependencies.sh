#!/usr/bin/env bash

source "$DOTFILES_CONFIG/.config/dotfiles/helper.sh"

_update_pacman_packages() {
  _print_info "Update all pacman packages"
  sudo pacman -Syu
}

_update_yay_packages() {
  _print_info "Update yay packages"
  yay -Syu
}

_update_pipx_packages() {
  _print_info "Update pipx packages"
  pipx upgrade-all
}

_update_self_managed() {
  local name update_cmd

  _config_value ".packages.self_managed[]" | while read -r dependency; do
    name=$(echo "$dependency" | yq ".name")
    update_cmd=$(echo "$dependency" | yq ".update_cmd")

    _print_info "Update $name"
    eval "$update_cmd"
  done
}

_update_git_file_downloads() {
  local name type cmd latest_version current_version

  _config_value ".packages.git_file_downloads[]" | while read -r dependency; do
    name=$(echo "$dependency" | yq ".name")
    type=$(echo "$dependency" | yq ".type")
    cmd=$(echo "$dependency" | yq ".cmd")

    _print_info "Update $name"
    latest_version=$(_get_latest_version "$name" "$type")
    current_version=$(_get_current_version "$name")

    if [ "$current_version" = "$latest_version" ]; then
      echo "Already up to date."
      continue
    fi

    eval "$cmd"
    _update_current_version "$name" "$latest_version"
  done
}

_update_git_repositories() {
  local name git_path post_cmd changes

  _config_value ".packages.git_repositories[]" | while read -r dependency; do
    name=$(echo "$dependency" | yq ".name")
    git_path=$(echo "$dependency" | yq ".path")
    post_cmd=$(echo "$dependency" | yq ".post_cmd")

    _print_info "Update $name"
    changes=$(git -C "$(eval realpath "$git_path")" pull)

    echo "$changes"

    if [ "$changes" = "Already up to date." ] || [ "$post_cmd" = null ]; then
      continue
    fi

    eval "$post_cmd"
  done
}

_print_manual_downloads() {
  local name link
  _print_info "Manual Downloads"

  _config_value ".packages.manual_downloads[]" | while read -r dependency; do
    name=$(echo "$dependency" | yq ".name")
    link=$(echo "$dependency" | yq ".link")

    _print_link "$name" "$link"
  done
}

update-dependencies() {
  _update_pacman_packages
  _update_yay_packages
  _update_pipx_packages
  _update_self_managed
  _update_git_repositories
  _update_git_file_downloads

  _print_manual_downloads
}
