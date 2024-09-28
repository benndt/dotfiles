prompt_segment() {
  local fg
  [[ -n $1 ]] && fg="%F{$1}" || fg="%f"
    echo -n "%{$fg%} "
  [[ -n $2 ]] && echo -n $2
}

prompt_newline() {
  echo -n "\n"
}

prompt_arrow() {
  prompt_segment magenta "❯"
}

prompt_double_arrow() {
  prompt_segment magenta "❯❯"
}

prompt_end() {
  echo -n "%{%f%}"
}

prompt_git() {
  (( $+commands[git] )) || return

  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  
  local PL_BRANCH_CHAR
  local ref dirty mode repo_path

   if [[ "$(command git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]]; then
    repo_path=$(command git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref="◈ $(command git describe --exact-match --tags HEAD 2> /dev/null)" || \
    ref="➦ $(command git rev-parse --short HEAD 2> /dev/null)"

    if [[ -n $dirty ]]; then
      prompt_segment yellow
    else
      prompt_segment green
    fi

    local ahead behind
    
    ahead=$(command git log --oneline @{upstream}.. 2>/dev/null)
    behind=$(command git log --oneline ..@{upstream} 2>/dev/null)
  
    if [[ -n "$ahead" ]] && [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21c5 '
    elif [[ -n "$ahead" ]]; then
      PL_BRANCH_CHAR=$'\u21b1 '
    elif [[ -n "$behind" ]]; then
      PL_BRANCH_CHAR=$'\u21b0 '
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" "
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" "
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" "
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '+'
    zstyle ':vcs_info:*' unstagedstr '!'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${${ref:gs/%/%%}/refs\/heads\//$PL_BRANCH_CHAR}${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_dir() {
  prompt_segment blue '%~'
}

prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black "$symbols"
}

prompt_execution_time() {
  [[ $(echo "$command_elapsed>=5.0" | bc -l) -eq 1 ]] && prompt_segment yellow "$(printf %.1f $command_elapsed | tr , .)s"
}

preexec() {
  unset command_elapsed

  command_timestamp=`date +%s.%N`
}

precmd() {
  setopt localoptions nopromptsubst

  local stop=`date +%s.%N`
  local start=${command_timestamp:-$stop}

  command_elapsed=$(echo "$stop - $start" | bc -l)

  unset command_timestamp
}

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_dir
  prompt_git
  prompt_newline
  prompt_arrow
  prompt_end
}

build_ps2() {
  RETVAL=$?
  prompt_double_arrow
  prompt_end
}

build_rprompt() {
  prompt_execution_time
}

PROMPT='%{%f%b%k%}$(build_prompt) '
RPROMPT='%{%f%b%k%}$(build_rprompt)'
PS2='%{%f%b%k%}$(build_ps2) '
