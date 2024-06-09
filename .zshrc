export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="coockoo"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(nvm z fzf)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export EDITOR=nvim

alias edittheme="$EDITOR ~/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme"
alias ag="ag --pager 'less -R'"
# use bat instead of cat
if type bat &>/dev/null; then
  alias cat='bat'
fi
# typos
alias gti='git'
alias gt='git'
alias vim='nvim'
alias vi='nvim'

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
  fpath=($(brew --prefix)/share/zsh-completions $fpath)

  autoload -Uz compinit
  compinit
fi

# Load .nvmrc file for directory enter
function enter_directory() {
  if [ "$PWD" != "$PREV_PWD" ]; then
    PREV_PWD="$PWD";
    [ -e ".nvmrc" ] && [ "$(node -v)" != "$(cat .nvmrc)" ] && nvm use > /dev/null 2>&1;
  fi
}
precmd() { enter_directory; }

# Load Glasgow Haskell Compiler
if [ -d "$HOME/.ghcup" ]; then
  path=($HOME/.ghcup/bin $path)
fi
if [ -d "$HOME/.cabal" ]; then
  path=($HOME/.cabal/bin $path)
fi

__git_files () {
  _wanted files expl 'local files' _files
}

[ -d "$(brew --prefix)/Caskroom/google-cloud-sdk" ] && source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Say hi to python
export PYENV_ROOT="$HOME/.pyenv"
if type pyenv &>/dev/null; then
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
fi
