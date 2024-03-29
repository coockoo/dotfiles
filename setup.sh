#!/usr/bin/env sh

function setup_link() {
  from=$1
  [ -z $2 ] && to=$1 || to=$2
  echo "linking $from -> $to..."
  if ! [ -f "$HOME/$to" ]; then
    ln "$from" "$HOME/$to";
    echo "linked  $from -> $to";
  else
    echo "exists  $from -> $to"
  fi
}

function setup_default_shell() {
  echo "Setting default shell to $1..."
  if ! [ "$SHELL" == "$1" ]; then
    chsh -s "$1"
    echo "$1 is now a default shell"
  else
    echo "$1 is already a default shell"
  fi
}

function setup_install_oh_my_zsh() {
  echo "Installing oh-my-zsh..."
  if ! [ -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Successfully installed oh-my-zsh"
  else
    echo "oh-my-zsh is already installed"
  fi
}

function setup_oh_my_zsh_theme() {
  echo "Installing oh-my-zsh theme $1..."
  if ! [ -f "$HOME/.oh-my-zsh/custom/themes/$1.zsh-theme" ]; then
    ln "./oh-my-zsh/custom/themes/$1.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/$1.zsh-theme"
    echo "Successfully installed oh-my-zsh theme"
  else
    echo "oh-my-zsh theme is already installed"
  fi
}

setup_default_shell "/bin/zsh"
setup_install_oh_my_zsh
setup_oh_my_zsh_theme "coockoo"

# Install Vim
echo "Installing Vim from brew..."
brew list vim || brew install vim
echo "Successfully installed Vim"

setup_link ".vimrc"

echo "Creating directories for Vim..."
mkdir -p "$HOME/.vim/colors"
echo "Directories for Vim created"

setup_link "vim/colors/custom.vim" ".vim/colors/custom.vim"
setup_link "vim/coc-settings.json" ".vim/coc-settings.json"

# Install diff-so-fancy
echo "Installing diff-so-fancy..."
if ! [ -x "$(command -v diff-so-fancy)" ]; then
  brew install diff-so-fancy
  echo "Successfully installed diff-so-fancy"
else
  echo "diff-so-fancy is already installed"
fi

# The Silver Searcher
echo "Installing the_silver_searcher..."
if ! [ -x "$(command -v ag)" ]; then
  brew install the_silver_searcher
  echo "Successfully installed the_silver_searcher"
else
  echo "the_silver_searcher is already installed"
fi

# Z - jump around
echo "Installing z - jump around..."
if [ "$(command -v _z)" != '_z' ]; then
  brew install z
  echo "Successfully installed z - jump around"
else
  echo "z - jump around is already installed"
fi

# FZF
echo "Installing fzf..."
if ! [ -x "$(command -v fzf)" ]; then
  brew install fzf
  $(brew --prefix)/opt/fzf/install
  echo "Successfully installed fzf"
else
  echo "fzf is already installed"
fi

# Install nvm
echo "Installing nvm..."
if ! [ -f "$HOME/.nvm/nvm.sh" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | zsh
  echo "Successfully installed nvm"
else
  echo "nvm is already installed"
fi

setup_link ".zshrc"
setup_link ".gitconfig"
setup_link ".gitignore_global"

echo "Done!"
