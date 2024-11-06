update-all() {
  print "$fg_bold[cyan]Update package list$reset_color"
  sudo apt-get update

  print "$fg_bold[cyan]Update all packages$reset_color"
  sudo apt-get upgrade
  sudo apt-get dist-upgrade

  if [ -f ~/.tmux/plugins/tpm/bin/update_plugins ]; then
    print "$fg_bold[cyan]Update tmux plugins$reset_color"
    ~/.tmux/plugins/tpm/bin/update_plugins all
  fi

  if command -v -- snap > /dev/null 2>&1; then
    print "$fg_bold[cyan]Update snap packages$reset_color"
    sudo snap refresh
  fi

  if command -v -- omz > /dev/null 2>&1; then
    print "$fg_bold[cyan]Update oh-my-zsh$reset_color"
    omz update
  fi

  print "$fg_bold[cyan]Remove unused packages$reset_color"
  sudo apt-get clean

  print "$fg_bold[cyan]Remove unavailable packages$reset_color"
  sudo apt-get autoremove -f
}
