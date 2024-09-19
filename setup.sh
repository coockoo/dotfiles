# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
chmod -R go-w "$(brew --prefix)/share"
# let homebrew install some nice deps
brew install z fzf fnm diff-so-fancy the_silver_searcher nvim rg
brew install --cask 1password iterm2 spotify firefox
# install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
