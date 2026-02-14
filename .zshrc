# envs
export ASEPRITE_BIN="aseprite"
export DEV="$HOME/dev"
export DOTFILES_CONFIG="$DEV/dotfiles"
export GODOT_BIN="godot"
export HISTTIMEFORMAT="%d/%m/%y %T "
export JUST_COMMAND_COLOR='green'
export PATH=~/.local/bin:$PATH
export XDG_CONFIG_HOME="$HOME/.config"
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.config/oh-my-zsh"

# zsh configs
ZSH_THEME="zen"

# plugins
plugins=(
    alias-finder
    aliases
    command-not-found
    fzf-tab
    git
    gitweb
    tmux
    tmuxp
    zsh-autosuggestions
    zsh-syntax-highlighting
)

fpath+=$ZSH_CUSTOM/plugins/zsh-completions/src
fpath+=$ZSH_CUSTOM/completions

source "$ZSH"/oh-my-zsh.sh

# keybindings
bindkey -e

# completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' cheaper yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:update' verbose minimal

# aliases
alias c="clear"
alias dev="cd $DEV"

# commands
source "$ZSH_CUSTOM/commands/update-dependencies.sh"

# catppuccin_mocha-zsh-syntax-highlighting
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# just
source <(just --completions=zsh)

# Load completions
autoload -Uz compinit && compinit

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
source ~/.config/fzf/catppuccin-fzf-mocha.sh
source <(fzf --zsh)
