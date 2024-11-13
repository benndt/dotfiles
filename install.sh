#!/usr/bin/env bash

print_info() {
  local text=$1

  print "${fg_bold[cyan]}${text}${reset_color}"
}

print_link() {
  local text=$1
  local link=$2

  local link_start link_end link_description

  link_start='\e]8;;'
  link_end='\e]8;;\e\\'
  link_description='\e\\'

  print "${fg[magenta]}${link_start}${link}${link_description}${text}${link_end}${reset_color}"
}

install_apt_packages() {
  print_info "Install apt packages"
  sudo apt install \
    tmux \
    stow \
    git
}

install_pip_packages() {
  print_info "Install pip packages"
  pip install --user \
    thefuck \
    tmuxp \
    "gdtoolkit==4.*"
}

install_snap_packages() {
  print_info "Install snap packages"
  snap install \
    btop \
    nvim \
    yq
}

install_tmux_plugins() {
  print_info "Install tmux plugins"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins all
}

install_ohmyzsh() {
  print_info "Install ohmyzsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  print_info "Install ohmyzsh plugin fzf-tab"
  git clone https://github.com/Aloxaf/fzf-tab "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/fzf-tab

  print_info "Install ohmyzsh plugin zsh-completions"
  git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}"/plugins/zsh-completions

  print_info "Install ohmyzsh plugin zsh-syntax-highlighting"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-syntax-highlighting

  print_info "Install ohmyzsh plugin zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"/plugins/zsh-autosuggestions

  print_info "Install catppuccin/zsh-syntax-highlighting"
  wget -P "$HOME/.zsh/" https://github.com/catppuccin/zsh-syntax-highlighting/raw/main/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh
}

install_fzf() {
  print_info "Install fzf"
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completion --no-update-rc
}

install_catppuccin_themes() {
  print_info "Install catppuccin/bat"
  rm "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
  wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
  bat cache --build

  print_info "Install catppuccin/delta"
  rm "$HOME/.config/delta/themes/catppuccin.gitconfig"
  wget -P "$HOME/.config/delta/themes" https://github.com/catppuccin/delta/raw/main/catppuccin.gitconfig

  print_info "Install catppuccin/btop"
  wget -qO- https://github.com/catppuccin/btop/releases/download/1.0.0/themes.tar.gz | tar -xzv -C "$XDG_CONFIG_HOME/btop/themes" --strip-components=1
}

install_zoxide() {
  print_info "Install zoxide"
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
}

install_deb_package() {
  local package=$1
  local repository=$2
  local url_template=$3

  print_info "Install $package"
  local latest_version
  latest_version=$(curl -s "https://api.github.com/repos/$repository/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v?([^"]+)".*/\1/')

  local url
  url=$(printf "$url_template" "$latest_version")

  curl -LO "$url"
  sudo dpkg -i "$(basename "$url")"
  rm "$(basename "$url")"
}

create_dotfile_symlinks() {
  print_info "Create symlink to dotfiles"
  stow . --target="$HOME" --no-folding
}

print_manual_installtions() {
  print_info "Manual installations"

  print_link "Godot" "https://godotengine.org/"
  print_link "JetBrainsMono Nerd Font" "https://www.nerdfonts.com/font-downloads"
  print_link "aseprite" "https://www.aseprite.org/"
  print_link "catppuccin/aseprite" "https://github.com/catppuccin/aseprite"
  print_link "catppuccin/godot" "https://github.com/catppuccin/godot"
  print_link "catppuccin/windows-terminal" "https://github.com/catppuccin/windows-terminal"
}

install() {
  print_manual_installtions

  install_apt_packages
  install_pip_packages
  install_snap_packages

  install_ohmyzsh
  install_fzf
  install_zoxide

  install_deb_package bat "sharkdp/bat" \
    "https://github.com/sharkdp/bat/releases/download/v%s/bat_%s_amd64.deb"
  install_deb_package delta "dandavison/delta" \
    "https://github.com/dandavison/delta/releases/download/%s/git-delta_%s_amd64.deb"
  install_deb_package ripgrep "BurntSushi/ripgrep" \
    "https://github.com/BurntSushi/ripgrep/releases/download/%s/ripgrep_%s-1_amd64.deb"

  install_catppuccin_themes

  create_dotfile_symlinks

  install_tmux_plugins
}

install
