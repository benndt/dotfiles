#!/usr/bin/env zsh

DOTFILES_CONFIG="$PWD"

source "$DOTFILES_CONFIG/.config/oh-my-zsh/scripts/helper.sh"
source "$DOTFILES_CONFIG/.config/oh-my-zsh/commands/update-dependencies.sh"

_create_installed_file() {
  touch $DOTFILES_CONFIG/.installed.yaml
}

_enable_services() {
  systemctl enable --now --user ssh-agent.service
  systemctl enable --now --user wallpaper.timer
}

_create_symlinks() {
  _print_info "Create symlinks to dotfiles"
  eval $(_config_list ".symlink_command")
}

_install_pacman_packages() {
  _print_info "Install pacman packages"
  sudo pacman -S $(_config_list ".packages.pacman[]")
}

_install_yay_packages() {
  _print_info "Install yay packages"
  yay -S $(_config_list ".packages.yay[]")
}

_install_pipx_packages() {
  _print_info "Install pipx packages"
  pipx install $(_config_list ".packages.pipx[]")
}

_build_system_cache() {
  _print_info "Build system cache"
  XDG_MENU_PREFIX=arch- kbuildsycoca6
}

_install_self_managed() {
  local name install_cmd

  _config_value ".packages.self_managed[]" | while read -r dependency; do
    name=$(echo "$dependency" | yq ".name")
    install_cmd=$(echo "$dependency" | yq ".install_cmd")

    _print_info "Install $name"
    eval "$install_cmd"
  done
}

_install_pacman_packages
_install_yay_packages
_install_pipx_packages
_install_self_managed

_update_git_repositories
_update_git_file_downloads

_build_system_cache

_print_manual_downloads

_create_symlinks

_enable_services
