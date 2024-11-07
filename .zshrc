# envs
export DEV="/mnt/c/Users/Benn/Documents/Dev"
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export HISTTIMEFORMAT="%d/%m/%y %T "
export PATH=/snap/bin:/home/benndt/.local/bin:$PATH
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
    thefuck
    tmux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

fpath+=$ZSH_CUSTOM/plugins/zsh-completions/src
fpath+=$ZSH_CUSTOM/completions

source "$ZSH"/oh-my-zsh.sh

# keybindings
bindkey -e

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' exact yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# aliases
alias c="clear"
alias dev="cd $DEV"
alias open-template="DISABLE_AUTO_TITLE='true' tmuxp load -y"
alias open-url="cmd.exe /c start"
alias p="open-project"
alias tks="tmux kill-server"

# commands
find "$ZSH_CUSTOM"/commands/*.sh | while read -r script; do
  if [[ -f "$script" ]]; then
    source "$script"
  fi
done

# catppuccin_mocha-zsh-syntax-highlighting
source ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh

# Load completions
autoload -Uz compinit && compinit

# thefuck
eval "$(thefuck --alias f)"

# zoxide
eval "$(zoxide init --cmd cd zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
