#!/usr/bin/env bash

readonly PACKAGE_VERSION_FILE="$XDG_CONFIG_HOME"/packages.yaml

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

_update_apt() {
  _print_info "Update apt package list"
  sudo apt -qq update

  _print_info "Update apt packages"
  sudo apt -qq upgrade
  sudo apt -qq dist-upgrade

  _print_info "Remove unused and unavailable apt packages"
  sudo apt -qq clean
  sudo apt -qq autoremove -f
}

_update_pip() {
  _print_info "Update pip packages"
  pip install --user --upgrade \
    thefuck \
    tmuxp \
    "gdtoolkit==4.*"
}

_update_snap() {
  if command -v -- snap >/dev/null 2>&1; then
    _print_info "Update snap packages"
    sudo snap refresh
  fi
}

_update_tmux() {
  if [ -f ~/.tmux/plugins/tpm/bin/update_plugins ]; then
    _print_info "Update tmux plugins"
    ~/.tmux/plugins/tpm/bin/update_plugins all
  fi
}

_update_ohmyzsh() {
  if command -v -- omz >/dev/null 2>&1; then
    _print_info "Update ohmyzsh"
    omz update | cat

    for plugin in "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/*/; do
      if [ -d "$plugin/.git" ]; then
        _print_info "Update ohmyzsh plugin $(basename "$plugin")"
        git -C "$plugin" pull
      fi
    done

    _print_info "Update catppuccin/zsh-syntax-highlighting"
    local latest_version current_version

    latest_version=$(curl -s "https://api.github.com/repos/catppuccin/zsh-syntax-highlighting/commits" | grep '"sha":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')
    current_version=$(yq ".catppuccin/zsh-syntax-highlighting" <"$PACKAGE_VERSION_FILE")

    if [ "$current_version" != "$latest_version" ]; then
      rm "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"
      wget --no-verbose -P "$HOME/.zsh/" https://github.com/catppuccin/zsh-syntax-highlighting/raw/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

      yq -i ".catppuccin/zsh-syntax-highlighting = \"${latest_version}\"" "$PACKAGE_VERSION_FILE"
    else
      echo "Already up to date."
    fi
  fi
}

_update_fzf() {
  if command -v -- fzf >/dev/null 2>&1; then
    _print_info "Update fzf"
    local changes
    changes=$(git -C ~/.fzf pull)

    if [ "$changes" != "Already up to date." ]; then
      ~/.fzf/install --key-bindings --completion --no-update-rc
    else
      echo "$changes"
    fi
  fi
}

_update_catppuccin_themes() {
  local latest_version current_version

  if command -v -- bat >/dev/null 2>&1; then
    _print_info "Update catppuccin/bat"

    latest_version=$(curl -s "https://api.github.com/repos/catppuccin/bat/commits" | grep '"sha":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')
    current_version=$(yq ".catppuccin/bat" <"$PACKAGE_VERSION_FILE")

    if [ "$current_version" != "$latest_version" ]; then
      rm "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
      wget --no-verbose -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
      bat cache --build

      yq -i ".catppuccin/bat = \"${latest_version}\"" "$PACKAGE_VERSION_FILE"
    else
      echo "Already up to date."
    fi
  fi

  if command -v -- delta >/dev/null 2>&1; then
    _print_info "Update catppuccin/delta"

    latest_version=$(curl -s "https://api.github.com/repos/catppuccin/delta/commits" | grep '"sha":' | head -n 1 | sed -E 's/.*"([^"]+)".*/\1/')
    current_version=$(yq ".catppuccin/delta" <"$PACKAGE_VERSION_FILE")

    if [ "$current_version" != "$latest_version" ]; then
      rm "$HOME/.config/delta/themes/catppuccin.gitconfig"
      wget --no-verbose -P "$HOME/.config/delta/themes" https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig

      yq -i ".catppuccin/delta = \"${latest_version}\"" "$PACKAGE_VERSION_FILE"
    else
      echo "Already up to date."
    fi
  fi

  if command -v -- btop >/dev/null 2>&1; then
    _print_info "Update catppuccin/btop"

    latest_version=$(curl -s "https://api.github.com/repos/catppuccin/btop/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$(yq ".catppuccin/btop" <"$PACKAGE_VERSION_FILE")

    if [ "$current_version" != "$latest_version" ]; then
      wget --no-verbose -qO- https://github.com/catppuccin/btop/releases/download/"$latest_version"/themes.tar.gz | tar -xzv -C "$XDG_CONFIG_HOME/btop/themes" --strip-components=1

      yq -i ".catppuccin/btop = \"${latest_version}\"" "$PACKAGE_VERSION_FILE"
    else
      echo "Already up to date."
    fi
  fi
}

_update_zoxide() {
  if command -v -- zoxide >/dev/null 2>&1; then
    _print_info "Update zoxide"

    local latest_version current_version
    latest_version=$(curl -s "https://api.github.com/repos/ajeetdsouza/zoxide/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$(zoxide -V | sed -n 's/.*'"$package"' \([0-9.]*\).*/\1/p')

    if [ "$current_version" != "$latest_version" ]; then
      curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/v"$latest_version"/install.sh | sh
    else
      echo "Already up to date."
    fi
  fi
}

_update_deb_package() {
  local package=$1
  local command=$2
  local repository=$3
  local url_template=$4

  if command -v "$command" >/dev/null 2>&1; then
    _print_info "Update $package"
    local latest_version current_version
    latest_version=$(curl -s "https://api.github.com/repos/$repository/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$("$command" -V | sed -n 's/.*'"$package"' \([0-9.]*\).*/\1/p')

    if [ "$current_version" != "$latest_version" ]; then
      local url
      url=$(printf "$url_template" "$latest_version")

      curl -LO "$url"
      sudo dpkg -i "$(basename "$url")"
      rm "$(basename "$url")"
    else
      echo "Already up to date."
    fi
  fi
}

_print_manual_updates() {
  _print_info "Manual updates"

  _print_link "Godot" "https://godotengine.org/"
  _print_link "JetBrainsMono Nerd Font" "https://www.nerdfonts.com/font-downloads"
  _print_link "aseprite" "https://www.aseprite.org/"
  _print_link "catppuccin/aseprite" "https://github.com/catppuccin/aseprite"
  _print_link "catppuccin/godot" "https://github.com/catppuccin/godot"
  _print_link "catppuccin/windows-terminal" "https://github.com/catppuccin/windows-terminal"
}

update-all() {
  _update_apt
  _update_pip
  _update_snap

  _update_tmux
  _update_ohmyzsh
  _update_fzf
  _update_zoxide

  _update_deb_package bat bat "sharkdp/bat" \
    "https://github.com/sharkdp/bat/releases/download/v%s/bat_%s_amd64.deb"
  _update_deb_package delta delta "dandavison/delta" \
    "https://github.com/dandavison/delta/releases/download/%s/git-delta_%s_amd64.deb"
  _update_deb_package ripgrep rg "BurntSushi/ripgrep" \
    "https://github.com/BurntSushi/ripgrep/releases/download/%s/ripgrep_%s-1_amd64.deb"

  _update_catppuccin_themes

  _print_manual_updates
}
