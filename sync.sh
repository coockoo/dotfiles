rm -f "$HOME/.zshrc" && ln ".zshrc" "$HOME/.zshrc"
rm -f "$HOME/.vimrc" && ln ".vimrc" "$HOME/.vimrc"
rm -f "$HOME/.gitignore_global" && ln ".gitignore_global" "$HOME/.gitignore_global"
rm -f "$HOME/.gitconfig" && ln ".gitconfig" "$HOME/.gitconfig"
rm -f "$HOME/.vim/colors/custom.vim" && ln "vim/colors/custom.vim" "$HOME/.vim/colors/custom.vim"
echo "done"
