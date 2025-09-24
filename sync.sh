# ghostty
mkdir -p $HOME/.config/ghostty
rm -f $HOME/.config/ghostty/config && ln ghostty/config $HOME/.config/ghostty/config
# skhd
mkdir -p $HOME/.config/skhd
rm -f $HOME/.config/skhd/skhdrc && ln skhdrc $HOME/.config/skhd/skhdrc
# ripgrep
rm -f $HOME/.config/ripgreprc && ln ripgreprc $HOME/.config/ripgreprc
# ruff
mkdir -p $HOME/.config/ruff
rm -f $HOME/.config/ruff/ruff.toml && ln ruff/ruff.toml $HOME/.config/ruff/ruff.toml
# zshrc
rm -f $HOME/.zshrc && ln .zshrc $HOME/.zshrc

rm -f "$HOME/.gitignore_global" && ln ".gitignore_global" "$HOME/.gitignore_global"
rm -f "$HOME/.gitconfig" && ln ".gitconfig" "$HOME/.gitconfig"
rm -f "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme" \
  && ln "oh-my-zsh/custom/themes/coockoo.zsh-theme" \
  "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme"
./sync/sync-nvim.sh

# user-specific binaries
mkdir -p $HOME/.bin
for file in bin/*; do
  if [[ -f "$file"  ]]; then
    if [[ "$file" == *.sh ]]; then
      filename=$(basename "$file")
      filename="${filename%.sh}"
      ln -F "$file" "$HOME/.bin/$filename"
    fi

    if [[ "$file" == *.swift ]]; then
      filename=$(basename "$file")
      filename="${filename%.swift}"
      swiftc -o "$HOME/.bin/$filename" "$file"
    fi
  fi
done

echo "done"
