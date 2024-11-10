#!/usr/bin/env bash

update-all() {
  local link_start link_end link_description

  link_start='\e]8;;'
  link_end='\e]8;;\e\\'
  link_description='\e\\'

  print "${fg_bold[cyan]}Update apt package list$reset_color"
  sudo apt update

  print "${fg_bold[cyan]}Update apt packages$reset_color"
  sudo apt upgrade
  sudo apt dist-upgrade

  print "${fg_bold[cyan]}Update pip packages$reset_color"
  pip install --user --upgrade \
    thefuck \
    tmuxp \
    "gdtoolkit==4.*"

  if command -v -- snap >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update snap packages$reset_color"
    sudo snap refresh
  fi

  if [ -f ~/.tmux/plugins/tpm/bin/update_plugins ]; then
    print "${fg_bold[cyan]}Update tmux plugins$reset_color"
    ~/.tmux/plugins/tpm/bin/update_plugins all
  fi

  if command -v -- omz >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update ohmyzsh$reset_color"
    omz update

    for plugin in "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/*/; do
      if [ -d "$plugin/.git" ]; then
        printf "${fg_bold[cyan]}Update ohmyzsh plugin: %s$reset_color\n" "${plugin%/}"
        git -C "$plugin" pull
      fi
    done

    print "${fg_bold[cyan]}Update catppuccin/zsh-syntax-highlighting$reset_color"
    rm "$HOME/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh"
    wget -P "$HOME/.zsh/" https://github.com/catppuccin/zsh-syntax-highlighting/raw/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
  fi

  if command -v -- fzf >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update fzf$reset_color"
    git -C ~/.fzf pull
    ~/.fzf/install --key-bindings --completion --no-update-rc
  fi

  if command -v -- bat >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update catppuccin/bat$reset_color"
    rm "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    bat cache --build
  fi

  if command -v -- delta >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update catppuccin/delta$reset_color"
    rm "$HOME/.config/delta/themes/catppuccin.gitconfig"
    wget -P "$HOME/.config/delta/themes" https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig
  fi

  if command -v -- btop >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update catppuccin/btop$reset_color"
    wget -qO- https://github.com/catppuccin/btop/releases/download/1.0.0/themes.tar.gz | tar -xzv -C "$XDG_CONFIG_HOME/btop/themes" --strip-components=1
  fi

  if command -v -- zoxide >/dev/null 2>&1; then
    print "${fg_bold[cyan]}Update zoxide$reset_color"
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
  fi

  local latest_version current_version

  if command -v -- bat >/dev/null 2>&1; then
    latest_version=$(curl -s "https://api.github.com/repos/sharkdp/bat/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$(bat -V | sed -n 's/.*bat \([0-9.]*\).*/\1/p')

    print "${fg_bold[cyan]}Update bat$reset_color"

    if [ "$current_version" != "$latest_version" ]; then
      curl -LO https://github.com/sharkdp/bat/releases/download/v"$latest_version"/bat_"$latest_version"_amd64.deb
      sudo dpkg -i bat_"$latest_version"_amd64.deb
      rm bat_"$latest_version"_amd64.deb
    else
      print "Already up to date."
    fi
  fi

  if command -v -- delta >/dev/null 2>&1; then
    latest_version=$(curl -s "https://api.github.com/repos/dandavison/delta/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$(delta -V | sed -n 's/.*delta \([0-9.]*\).*/\1/p')

    print "${fg_bold[cyan]}Update delta$reset_color"

    if [ "$current_version" != "$latest_version" ]; then
      curl -LO https://github.com/dandavison/delta/releases/download/"$latest_version"/git-delta_"$latest_version"_amd64.deb
      sudo dpkg -i git-delta_"$latest_version"_amd64.deb
      rm git-delta_"$latest_version"_amd64.deb
    else
      print "Already up to date."
    fi
  fi

  if command -v -- rg >/dev/null 2>&1; then
    latest_version=$(curl -s "https://api.github.com/repos/BurntSushi/ripgrep/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')
    current_version=$(rg -V | sed -n 's/.*ripgrep \([0-9.]*\).*/\1/p')

    print "${fg_bold[cyan]}Update ripgrep$reset_color"

    if [ "$current_version" != "$latest_version" ]; then
      curl -LO https://github.com/BurntSushi/ripgrep/releases/download/"$latest_version"/ripgrep_"$latest_version"-1_amd64.deb
      sudo dpkg -i ripgrep_"$latest_version"-1_amd64.deb
      rm ripgrep_"$latest_version"-1_amd64.deb
    else
      print "Already up to date."
    fi
  fi

  print "${fg_bold[cyan]}Remove unused apt packages$reset_color"
  sudo apt clean

  print "${fg_bold[cyan]}Remove unavailable apt packages$reset_color"
  sudo apt autoremove -f

  print "${fg_bold[cyan]}Manual updates$reset_color"
  print "${fg[magenta]}${link_start}https://www.aseprite.org/${link_description}aseprite${link_end}$reset_color"
  print "${fg[magenta]}${link_start}https://github.com/catppuccin/aseprite${link_description}catppuccin/aseprite${link_end}$reset_color"
  print "${fg[magenta]}${link_start}https://github.com/catppuccin/godot${link_description}catppuccin/godot${link_end}$reset_color"
  print "${fg[magenta]}${link_start}https://github.com/catppuccin/windows-terminal${link_description}catppuccin/windows-terminal${link_end}$reset_color"
  print "${fg[magenta]}${link_start}https://godotengine.org/${link_description}Godot${link_end}$reset_color"
  print "${fg[magenta]}${link_start}https://www.nerdfonts.com/font-downloads${link_description}JetBrainsMono Nerd Font${link_end}$reset_color"
}
