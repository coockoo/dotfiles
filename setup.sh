#!/usr/bin/env sh

# Set zsh as default shell
EXPECTED_SHELL="/bin/zsh"

if ! [ "$SHELL" == "$EXPECTED_SHELL" ]; then
  echo "Setting default shell to zsh..."
  chsh -s /bin/zsh
fi

# Check if oh-my-zsh is installed
if ! [ -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install diff so fancy
if ! [ -x "$(command -v diff-so-fancy)" ]; then
  echo "Installing diff-so-fancy..."
  brew install diff-so-fancy
fi

echo "Linkind config and startup files..."
ln .zshrc ~/.zshrc
ln .zprofile ~/.zprofile
ln .vimrc ~/.vimrc
ln .gitconfig ~/.gitconfig
ln .gitignore_global ~/.gitignore_global

echo "Done!"
