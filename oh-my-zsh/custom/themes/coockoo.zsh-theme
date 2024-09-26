function node_status() {
  local res=$(node -v 2> /dev/null)
  if [[ -n $res ]]; then
    echo "$fg_bold[blue][$fg[green]$res$fg[blue]]$reset_color"
  else
    echo ''
  fi
}

PROMPT="$fg[cyan]%c$reset_color"
PROMPT+=' $(node_status)'
PROMPT+=' $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[blue][$fg[yellow]"
ZSH_THEME_GIT_PROMPT_SUFFIX="$reset_color "
ZSH_THEME_GIT_PROMPT_DIRTY="$fg_bold[blue]] $fg[yellow]✗"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg_bold[blue]] $fg[green]✔"
