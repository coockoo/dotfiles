rm "$HOME/.vimrc" && ln ".vimrc" "$HOME/.vimrc"
rm "$HOME/.vim/colors/custom.vim" && ln "vim/colors/custom.vim" "$HOME/.vim/colors/custom.vim"
rm "$HOME/.gitignore_global" && ln ".gitignore_global" "$HOME/.gitignore_global"
echo "done"
