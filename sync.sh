rm -f "$HOME/.zshrc" && ln ".zshrc" "$HOME/.zshrc"
rm -f "$HOME/.gitignore_global" && ln ".gitignore_global" "$HOME/.gitignore_global"
rm -f "$HOME/.gitconfig" && ln ".gitconfig" "$HOME/.gitconfig"
rm -f "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme" \
  && ln "oh-my-zsh/custom/themes/coockoo.zsh-theme" \
  "$HOME/.oh-my-zsh/custom/themes/coockoo.zsh-theme"
./sync/sync-nvim.sh
echo "done"
