# Dotfiles and setup

## Private Configuration

The best place for it is a `~/.zprofile` [file](https://zsh.sourceforge.io/Doc/Release/Files.html).
It is executed before `~/.zshrc`, which is public and is present in this repository.

```sh
export EMAIL="username@provider.com" # for Git
export GIT_AUTHOR_NAME="Author Name" # for Git
```
