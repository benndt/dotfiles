#!/usr/bin/env bash

readonly CONFIG_FILE="$DEV/dotfiles/dependencies.yaml"

_print_info() {
  local text=$1

  print "\n${fg_bold[cyan]}${text}${reset_color}"
}

_print_link() {
  local text=$1
  local link=$2

  local link_start link_end link_description

  link_start='\e]8;;'
  link_end='\e]8;;\e\\'
  link_description='\e\\'

  print "${fg[magenta]}${link_start}${link}${link_description}${text}${link_end}${reset_color}"
}

_read_config() {
  yq "$1" "$CONFIG_FILE"
}

_update_apt_packages() {
  _print_info "Update apt package list"
  sudo apt -qq update

  _print_info "Update apt packages"
  sudo apt -qq upgrade
  sudo apt -qq dist-upgrade

  _print_info "Remove unused and unavailable apt packages"
  sudo apt -qq clean
  sudo apt -qq autoremove -f
}

_update_pip_packages() {
  local packages=()
  while IFS= read -r package; do
    packages+=("$package")
  done < <(_read_config ".dotfiles.dependencies.pip[]")

  _print_info "Update pip packages"
  pip install --user --upgrade "${packages[@]}"
}

_update_snap_packages() {
  if command -v -- snap >/dev/null 2>&1; then
    _print_info "Update snap packages"
    sudo snap refresh
  fi
}

_update_deb_packages() {
  local amount name update_cmd latest_version current_version
  amount=$(_read_config ".dotfiles.dependencies.deb | length")

  for ((i = 0; i < amount; i++)); do
    name=$(_read_config ".dotfiles.dependencies.deb.$i.name")
    cmd=$(_read_config ".dotfiles.dependencies.deb.$i.cmd")
    url_template=$(_read_config ".dotfiles.dependencies.deb.$i.url_template")

    _print_info "Update $name"
    latest_version=$(curl -s "https://api.github.com/repos/$name/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$("$cmd" -V | sed -n 's/.*'"$(basename "$name")"' \([0-9.]*\).*/\1/p')

    if [ "$current_version" != "$latest_version" ]; then
      local url
      url=$(printf "$url_template" "$latest_version")

      curl -LO "$url"
      sudo dpkg -i "$(basename "$url")"
      rm "$(basename "$url")"
    else
      echo "Already up to date."
    fi
  done
}

_update_self() {
  local amount name update_cmd
  amount=$(_read_config ".dotfiles.dependencies.self | length")

  for ((i = 0; i < amount; i++)); do
    name=$(_read_config ".dotfiles.dependencies.self.$i.name")
    update_cmd=$(_read_config ".dotfiles.dependencies.self.$i.update_cmd")

    _print_info "Update $name"
    eval "$update_cmd"
  done
}

_update_git_file() {
  local amount name type cmd
  amount=$(_read_config ".dotfiles.dependencies.git_file | length")

  for ((i = 0; i < amount; i++)); do
    name=$(_read_config ".dotfiles.dependencies.git_file.$i.name")
    type=$(_read_config ".dotfiles.dependencies.git_file.$i.type")
    cmd=$(_read_config ".dotfiles.dependencies.git_file.$i.cmd")

    _print_info "Update $name"

    if [ "$type" = "commit" ]; then
      latest_version=$(curl -s "https://api.github.com/repos/$name/commits" | grep '"sha":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')
    else
      latest_version=$(curl -s "https://api.github.com/repos/$name/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    fi

    current_version=$(yq ".$name" <"$PACKAGE_VERSION_FILE")

    if [ "$current_version" != "$latest_version" ]; then
      eval "$cmd"

      yq -i ".$name = \"${latest_version}\"" "$PACKAGE_VERSION_FILE"
    else
      echo "Already up to date."
    fi
  done
}

_update_git_clones() {
  local amount name git_path post_cmd changes
  amount=$(_read_config ".dotfiles.dependencies.git_clone | length")

  for ((i = 0; i < amount; i++)); do
    name=$(_read_config ".dotfiles.dependencies.git_clone.$i.name")
    git_path=$(_read_config ".dotfiles.dependencies.git_clone.$i.path")
    post_cmd=$(_read_config ".dotfiles.dependencies.git_clone.$i.post_cmd")

    _print_info "Update $name"
    changes=$(git -C "$(eval realpath "$git_path")" pull)

    if [ "$changes" != "Already up to date." ] && [ "$post_cmd" != null ]; then
      eval "$post_cmd"
    else
      echo "$changes"
    fi
  done
}

_print_manual_updates() {
  local manual_updates name link
  manual_updates=$(yq ".dotfiles.dependencies.manual[] | .[]" <"$CONFIG_FILE")

  _print_info "Manual Updates"
  for manual in "${manual_updates[@]}"; do
    name=$(echo "$manual" | yq '.name')
    link=$(echo "$manual" | yq '.link')

    _print_link "$name" "$link"
  done
}

update-all-new() {
  while IFS= read -r dependency; do
    case "$dependency" in
    apt)
      _update_apt_packages
      ;;
    pip)
      _update_pip_packages
      ;;
    snap)
      _update_snap_packages
      ;;
    deb)
      _update_deb_packages
      ;;
    self)
      _update_self
      ;;
    git_clone)
      _update_git_clones
      ;;
    git_file)
      _update_git_file
      ;;
    manual)
      _print_manual_updates
      ;;
    esac
  done < <(_read_config ".dotfiles.dependencies | keys | .[]")
}
