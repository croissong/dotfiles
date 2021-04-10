declare -A ZINIT
ZINIT[HOME_DIR]=$XDG_CONFIG_HOME/zsh/.zinit

source $ZINIT[HOME_DIR]/bin/zinit.zsh

zinit wait lucid light-mode for \
	atinit"zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' \
	    zsh-users/zsh-completions

zinit light zinit-zsh/z-a-bin-gem-node

zinit from"gh-r" sbin"direnv" mv"direnv* -> direnv" \
	atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
	src="zhook.zsh" for \
	    direnv/direnv
