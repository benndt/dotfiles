#!/usr/bin/env bash

# Godot
open-url https://godotengine.org/download/windows/

# JetBrains Font
open-url https://www.nerdfonts.com/font-downloads

# apt
sudo apt install \
  tmux \
  stow \
  git

# snap
snap install \
  btop \
  nvim

# pip
pip install --user \
  thefuck \
  tmuxp \
  "gdtoolkit==4.*"

# ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ohmyzsh plugins
git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

# bat
curl -LO https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb
sudo dpkg -i bat_0.24.0_amd64.deb
rm bat_0.24.0_amd64.deb

# gitdelta
curl -LO https://github.com/dandavison/delta/releases/download/0.18.2/git-delta_0.18.2_amd64.deb
sudo dpkg -i git-delta_0.18.2_amd64.deb
rm git-delta_0.18.2_amd64.deb

# ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep_14.1.1-1_amd64.deb
sudo dpkg -i ripgrep_14.1.1-1_amd64.deb
rm ripgrep_14.1.1-1_amd64.deb

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# catppuccin/zsh-syntax-highlighting
wget -P "$HOME/.zsh/" https://github.com/catppuccin/zsh-syntax-highlighting/raw/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

# catppuccin/bat
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
bat cache --build

# catppuccin/delta
mkdir -p "$XDG_CONFIG_HOME/delta/themes"
wget -P "$XDG_CONFIG_HOME/delta/themes" https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig

# catppuccin/btop
mkdir -p "$XDG_CONFIG_HOME/btop/themes"
wget -qO- https://github.com/catppuccin/btop/releases/download/1.0.0/themes.tar.gz | tar -xzv -C "$XDG_CONFIG_HOME/btop/themes" --strip-components=1

# catppuccin/windows-terminal
open-url https://github.com/catppuccin/windows-terminal

# catppuccin/godot
open-url https://github.com/catppuccin/godot
