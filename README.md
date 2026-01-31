# Dotfiles

## Usage

> [!WARNING]
> All requirements should be installed before you run stow.

Add symlinks for all files in `.` to the target folder:

```bash
stow . --target="$HOME" --no-folding
```

### Modifications

> [!NOTE]
> The dotfiles are heavily customized to my needs and can either be copied and modified or used as inspiration.

If you want to copy it, the following files should be adjusted:

- `.config/nvim/lua/configs/lspconfig.lua`
  - Remove the gdscript config if you work on Linux.
- `.gitconfig`
  - Use your own user data
- `.zshrc`
  - Change the `DEV` env to your main working directory
  - Change the alias for `aseprite`, `godot` and `open`

If you don't use `aseprite` and `godot` you can also remove more configs.

## Requirements

- All [catppuccin](https://github.com/catppuccin/catppuccin) dependencies should be downloaded with theme `mocha`.

### [aseprite](https://www.aseprite.org/)

- [catppuccin/aseprite](https://github.com/catppuccin/aseprite)

### [btop](https://github.com/aristocratos/btop)

- [catppuccin/btop](https://github.com/catppuccin/btop)

### [git](https://git-scm.com/downloads/linux)

- [bat](https://github.com/sharkdp/bat)
- [catppuccin/bat](https://github.com/catppuccin/bat)
- [catppuccin/delta](https://github.com/catppuccin/delta)
- [git-delta](https://github.com/dandavison/delta)

### [godot](https://godotengine.org/)

- [catppuccin/godot](https://github.com/catppuccin/godot)
- [gdtoolkit](https://github.com/Scony/godot-gdscript-toolkit)

### [just](https://github.com/casey/just)

### [nvim](https://github.com/neovim/neovim) / [nvchad](https://nvchad.com/)

- [ripgrep](https://github.com/BurntSushi/ripgrep)

### [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

- [catppuccin/zsh-syntax-highlighting](https://github.com/catppuccin/zsh-syntax-highlighting)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-completions](https://github.com/zsh-users/zsh-completions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### [stow](https://www.gnu.org/software/stow)

### [tmux](https://github.com/tmux/tmux)

- [tmuxp](https://github.com/tmux-python/tmuxp)
- [tpm](https://github.com/tmux-plugins/tpm)

### windows-terminal

- [catppuccin/windows-terminal](https://github.com/catppuccin/windows-terminal)
- [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads)
