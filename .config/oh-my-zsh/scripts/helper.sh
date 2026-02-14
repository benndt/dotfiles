#!/usr/bin/env zsh

PACKAGE_VERSION_FILE="$DOTFILES_CONFIG/.installed.yaml"
CONFIG_FILE="$DOTFILES_CONFIG/config.yaml"

RESET_COLOR='\033[0m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LINK_START='\e]8;;'
LINK_END='\e]8;;\e\\'
LINK_NAME='\e\\'

_print_info() {
  local text=$1

  echo -e "${CYAN}${text}${RESET_COLOR}"
}

_print_link() {
  local text=$1
  local link=$2

  echo -e "${PURPLE}${LINK_START}${link}${LINK_NAME}${text}${LINK_END}${RESET_COLOR}"
}

_config_value() {
  yq -o=j -I=0 "$1" "$CONFIG_FILE"
}

_config_list() {
  yq "$1" "$CONFIG_FILE"
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

  if [ "$command" != "" ]; then
    "$command" -V | sed -n 's/.*'"$(basename "$name")"' \([0-9.]*\).*/\1/p'
    return
  fi

  yq ".$name" < "$PACKAGE_VERSION_FILE"
}

_update_current_version() {
  local name="$1"
  local version="$2"

  yq -i ".$name = \"${version}\"" "$PACKAGE_VERSION_FILE"
}
