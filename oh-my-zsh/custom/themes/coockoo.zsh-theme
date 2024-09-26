function node_status() {
  local res=$(node -v 2> /dev/null)
  if [[ -n $res ]]; then
    echo "$fg_bold[blue][$fg[green]$res$fg[blue]]"
  else
    echo ''
  fi
}

PROMPT='$fg[cyan]%c$reset_color '
PROMPT+='$(node_status)$reset_color '
PROMPT+='$(git_prompt_info)$reset_color '

ZSH_THEME_GIT_PROMPT_PREFIX="$fg_bold[blue][$fg[yellow]"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="$fg_bold[blue]] $fg[yellow]✗"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg_bold[blue]] $fg[green]✔"
