export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="coockoo"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git nvm z fzf)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=vim

alias edittheme="$EDITOR ~/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme"
alias ag="ag --pager 'less -R'"
# typos
alias gti='git'
alias gt='git'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

export FZF_DEFAULT_OPTS='--reverse'
# Prevent duplicates in history
export HISTCONTROL="ignoredups:erasedups"
# Ignore ls bf bg exit etc... entries in history
export HISTORY_IGNORE="(ls|[bf]g|exit|z|git status|git s|git diff|git d|git dc|vim|history)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

  autoload -Uz compinit
  compinit
fi

# unknown line from the .zprofile
fpath=(/usr/local/share/zsh-completions $fpath)

# Load .nvmrc file for directory enter
function enter_directory() {
  if [ "$PWD" != "$PREV_PWD" ]; then
    PREV_PWD="$PWD";
    [ -e ".nvmrc" ] && [ "$(node -v)" != "$(cat .nvmrc)" ] && nvm use > /dev/null 2>&1;
  fi
}
precmd() { enter_directory; }

# Load Glasgow Haskell Compiler
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Load private configuration
[ -f "$HOME/.zshrc.private" ] && source "$HOME/.zshrc.private"
