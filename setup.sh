# installa homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
# let homebrew install some nice deps
brew install z fzf fnm diff-so-fancy the_silver_searcher nvim
brew install --cask 1password iterm2 spotify firefox
