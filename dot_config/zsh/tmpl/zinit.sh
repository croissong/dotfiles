declare -A ZINIT
ZINIT[HOME_DIR]=$ZDOTDIR/.zinit

source $ZINIT[HOME_DIR]/bin/zinit.zsh

zinit wait lucid light-mode for \
	atinit"zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting \
	atload"_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' \
	    zsh-users/zsh-completions

zinit lucid light-mode for \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-patch-dl

zinit from"gh-r" sbin"direnv" mv"direnv* -> direnv" \
	atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
	src="zhook.zsh" for \
	direnv/direnv

{{ include "fzf.sh" }}
