update-all() {
  print "$fg[blue]Update package list$reset_color"
  sudo apt-get update

  print "$fg[blue]Update all packages$reset_color"
  sudo apt-get upgrade
  sudo apt-get dist-upgrade

  if [ -f ~/.tmux/plugins/tpm/bin/update_plugins ]; then
    print "$fg[blue]Update tmux plugins$reset_color"
    ~/.tmux/plugins/tpm/bin/update_plugins all
  fi

  if command -v -- snap > /dev/null 2>&1; then
    print "$fg[blue]Update snap packages$reset_color"
    sudo snap refresh
  fi

  if command -v -- omz > /dev/null 2>&1; then
    print "$fg[blue]Update oh-my-zsh$reset_color"
    omz update
  fi

  #print "$fg[blue]Remove old kernels$reset_color"
  #dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p' | xargs sudo apt-get -y purge

  print "$fg[blue]Remove unused packages$reset_color"
  sudo apt-get clean

  print "$fg[blue]Remove unavailable packages$reset_color"
  sudo apt-get autoremove -f
}
