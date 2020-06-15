# Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/.yarn/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"

# Load .nvmrc file for directory enter
enter_directory() {
	if [ "$PWD" != "$PREV_PWD" ]; then
		PREV_PWD="$PWD";
		if [ -e ".nvmrc" ]; then
			if [ "$(node -v)" != "$(cat .nvmrc)" ]; then
				nvm use > /dev/null 2>&1;
			fi
		fi
	fi
}
precmd() { enter_directory; }

alias ls='ls -G'
alias gti='git'
alias gt='git'
alias ag="ag --pager 'less -R'"

fpath=(/usr/local/share/zsh-completions $fpath)

# open a new tab on Terminal with the current working dir
function newtab {
	osascript -e "
		tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down
		tell application \"Terminal\" to do script \"cd \\\"$(PWD)\\\"\" in selected tab of the front window
	" > /dev/null 2>&1
}

# Prevent duplicates in history
export HISTCONTROL="ignoredups:erasedups"
# Ignore ls bf bg exit etc... entries in history
export HISTORY_IGNORE="(ls|[bf]g|exit|z|git status|git s|git diff|git d|git dc|vim|history)"
