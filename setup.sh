#!/usr/bin/env sh

# Set zsh as default shell
EXPECTED_SHELL="/bin/zsh"

echo "Setting default shell to zsh..."
if ! [ "$SHELL" == "$EXPECTED_SHELL" ]; then
  chsh -s /bin/zsh
  echo "zsh is now a default shell"
else
  echo "zsh is already a default shell"
fi

echo "Installing oh-my-zsh..."
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Successfully installed oh-my-zsh"
else
  echo "oh-my-zsh is already installed"
fi

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

echo "Linking color scheme"
if ! [ -f "$HOME/.vim/colors/custom.vim" ]; then
  mkdir -p "$HOME/.vim/colors"
  ln vim/colors/custom.vim "$HOME/.vim/colors/custom.vim"
  echo "Successfully linked vim colors"
else
  echo "Vim colors successfully linked"
fi

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
