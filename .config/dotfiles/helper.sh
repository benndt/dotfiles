#!/usr/bin/env bash

readonly PACKAGE_VERSION_FILE="$DOTFILES_CONFIG/packages.yaml"
readonly CONFIG_FILE="$DOTFILES_CONFIG/config.yaml"

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

_config_value() {
  yq -o=j -I=0 "$1" "$CONFIG_FILE"
}

_get_latest_version() {
  local name="$1"
  local type="$2"

  if [ "$type" = "commit" ]; then
    curl -s "https://api.github.com/repos/$name/commits" | grep '"sha":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/'
    return
  fi

  if [ "$type" = "release" ]; then
    curl -s "https://api.github.com/repos/$name/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/'
    return
  fi

  echo null
}

_get_current_version() {
  local name="$1"
  local command="$2"

  if [ "$command" != null ]; then
    "$command" -V | sed -n 's/.*'"$(basename "$name")"' \([0-9.]*\).*/\1/p'
    return
  fi

  yq ".$name" <"$PACKAGE_VERSION_FILE"
}

_update_current_version() {
  local name="$1"
  local version="$2"

  yq -i ".$name = \"${version}\"" "$PACKAGE_VERSION_FILE"
}
