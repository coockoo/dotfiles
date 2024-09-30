export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="coockoo"
alias edittheme="$EDITOR ~/.oh-my-zsh/themes/$ZSH_THEME.zsh-theme"

zstyle ':omz:update' mode disabled
source $ZSH/oh-my-zsh.sh

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

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

# https://github.com/junegunn/fzf
if type fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS='--reverse'
  source <(fzf --zsh)
fi

# https://github.com/rupa/z
function setup_z() {
  local z_path=$(brew --prefix)/etc/profile.d/z.sh
  if [ -f $z_path ]; then
    . $z_path
  fi
}
setup_z

# https://github.com/Schniz/fnm
if type fnm &>/dev/null; then
  eval "$(fnm env --use-on-cd --shell zsh --log-level error)"
fi

setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP

# Prevent duplicates in history
export HISTCONTROL="ignoredups:erasedups"
# Ignore ls bf bg exit etc... entries in history
export HISTORY_IGNORE="(ls|[bf]g|exit|z|git status|git s|git diff|git d|git dc|vim|history)"

if type brew &>/dev/null; then
  fpath=($(brew --prefix)/share/zsh-completions $fpath)

  autoload -Uz compinit
  compinit
fi

# Load Glasgow Haskell Compiler
[ -d "$HOME/.ghcup" ] && path=($HOME/.ghcup/bin $path)
[ -d "$HOME/.cabal" ] && path=($HOME/.cabal/bin $path)
# ghc-wasm
# [ -d "$HOME/.ghc-wasm" ] && source "$HOME/.ghc-wasm/env"

__git_files () {
  _wanted files expl 'local files' _files
}

[ -d "$(brew --prefix)/Caskroom/google-cloud-sdk" ] && source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Say hi to python
if type pyenv &>/dev/null; then
  eval "$(pyenv init -)"
fi
