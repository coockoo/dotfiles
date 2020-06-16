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
if ! [ -f "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme" ]; then
  ln oh-my-zsh/custom/themes/coockoo.zsh-theme "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme"
  echo "Successfully installed oh-my-zsh theme"
else
  echo "oh-my-zsh theme is already installed"
fi

# Install Vim
echo "Installing Vim from brew..."
brew list vim || brew install vim
echo "Successfully installed Vim"

echo "Linking .vimrc..."
if ! [ -f "$HOME/.vimrc" ]; then
  ln .vimrc "$HOME/.vimrc"
fi

# Create directory for Vim
echo "Creating directory for Vim..."
mkdir -p $HOME/.vim/bundle
echo "Directory for Vim created"

# Setup Vim colorscheme
echo "Linking color scheme"
if ! [ -f "$HOME/.vim/colors/custom.vim" ]; then
  mkdir -p "$HOME/.vim/colors"
  ln vim/colors/custom.vim "$HOME/.vim/colors/custom.vim"
  echo "Successfully linked vim colors"
else
  echo "Vim colors successfully linked"
fi

# Install Vundle for Vim
echo "Installing Vundle for Vim..."
if ! [ -d "$HOME/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
  vim +PluginInstall +qall
  echo "Vundle successfully installed"
else
  echo "Vundle is alredy installed"
fi

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
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh
  echo "Successfully installed nvm"
else
  echo "nvm is already installed"
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
