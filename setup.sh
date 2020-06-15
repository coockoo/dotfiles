#!/usr/bin/env sh

# Set zsh as default shell
EXPECTED_SHELL="/bin/zsh"

# Set default shell to zsh
echo "Setting default shell to zsh..."
if ! [ "$SHELL" == "$EXPECTED_SHELL" ]; then
  chsh -s /bin/zsh
  echo "zsh is now a default shell"
else
  echo "zsh is already a default shell"
fi

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Successfully installed oh-my-zsh"
else
  echo "oh-my-zsh is already installed"
fi

# Install custom oh-my-zsh theme
echo "Installing oh-my-zsh theme..."
if ! [ -d "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme" ]; then
  ln oh-my-zsh/custom/themes/coockoo.zsh-theme "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme"
  echo "Successfully installed oh-my-zsh theme"
else
  echo "oh-my-zsh theme is already installed"
fi

# Install Vim
echo "Installing Vim from brew..."
brew list vim || brew install vim
echo "Successfully installed Vim"

# Install diff-so-fancy
echo "Installing diff-so-fancy..."
if ! [ -x "$(command -v diff-so-fancy)" ]; then
  brew install diff-so-fancy
  echo "Successfully installed diff-so-fancy"
else
  echo "diff-so-fancy is already installed"
fi

# Create directory for Vim
echo "Creating directory for Vim..."
mkdir -p $HOME/.vim
echo "Directory for Vim created"

# Install Pathogen for Vim
echo "Installing pathogen for Vim..."
if ! [ -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/bundle" && \
  curl -LSso "$HOME/.vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim
  echo "Pathogen successfully installed"
else
  echo "Pathogen is alredy installed"
fi

# Setup Vim colorscheme
echo "Linking color scheme"
if ! [ -f "$HOME/.vim/colors/custom.vim" ]; then
  mkdir -p "$HOME/.vim/colors"
  ln vim/colors/custom.vim "$HOME/.vim/colors/custom.vim"
  echo "Successfully linked vim colors"
else
  echo "Vim colors successfully linked"
fi

# Install Vim dependencies
echo "Installing Vim dependencies..."

# Neocomplete
echo "Installing neocomplete.vim..."
if ! [ -d "$HOME/.vim/bundle/neocomplete.vim" ]; then
  git clone https://github.com/shougo/neocomplete.vim "$HOME/.vim/bundle/neocomplete.vim"
  echo "Successfully installed neocomplete.vim"
else
  echo "neocomplete.vim is already installed"
fi

# NERDTree
echo "Installing nerdtree"
if ! [ -d "$HOME/.vim/bundle/nerdtree" ]; then
  git clone https://github.com/scrooloose/nerdtree "$HOME/.vim/bundle/nerdtree"
  echo "Successfully installed nerdtree"
else
  echo "nerdtree is already installed"
fi

# NERDTree tabs
echo "Installing vim-nerdtree-tabs"
if ! [ -d "$HOME/.vim/bundle/vim-nerdtree-tabs" ]; then
  git clone https://github.com/jistr/vim-nerdtree-tabs "$HOME/.vim/bundle/vim-nerdtree-tabs"
  echo "Successfully installed vim-nerdtree-tabs"
else
  echo "vim-nerdtree-tabs is already installed"
fi

# The Silver Searcher
echo "Installing the_silver_searcher..."
if ! [ -x "$(command -v ag)" ]; then
  brew install the_silver_searcher
  echo "Successfully installed the_silver_searcher"
else
  echo "the_silver_searcher is already installed"
fi

# Link config and startup files
echo "Linkind config and startup files..."

echo "Linking .zshrc..."
if ! [ -f "$HOME/.zshrc" ]; then
  ln .zshrc "$HOME/.zshrc"
fi

echo "Linking .zprofile..."
if ! [ -f "$HOME/.zprofile" ]; then
  ln .zprofile "$HOME/.zprofile"
fi

echo "Linking .vimrc..."
if ! [ -f "$HOME/.vimrc" ]; then
  ln .vimrc "$HOME/.vimrc"
fi

echo "Linking .gitconfig..."
if ! [ -f "$HOME/.gitconfig" ]; then
  ln .gitconfig "$HOME/.gitconfig"
fi

echo "Linking .gitignore_global..."
if ! [ -f "$HOME/.gitignore_global" ]; then
  ln .gitignore_global "$HOME/.gitignore_global"
fi

echo "Successfully linked startup files"

echo "Done!"
