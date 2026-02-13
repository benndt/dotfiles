# Dotfiles

## Overview

- Window Manager: [Hyprland](https://github.com/hyprwm/Hyprland)
- Shell: [zsh](https://www.zsh.org/) with [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- Terminal: [alacritty](https://github.com/alacritty/alacritty)
- Bar: [Waybar](https://github.com/Alexays/Waybar)
- Notification Daemon: [Dunst](https://github.com/dunst-project/dunst)
- Launcher: [Rofi](https://github.com/davatorium/rofi)
- Screenshot Tool: [Flameshot](https://github.com/flameshot-org/flameshot)

## Installation

1. Run `./install.sh` to install all required dependencies.
1. All manual [catppuccin](https://github.com/catppuccin/catppuccin) dependencies should be downloaded with theme `mocha`.

## Update

To create missing symlinks you can run this command.

```bash
stow . --target="$HOME" --no-folding
```

After the installation you can also run `update-depedencies` to update your dependencies.
