declare -A ZINIT
ZINIT[HOME_DIR]=$ZDOTDIR/.zinit
ZINIT[COMPINIT_OPTS]=-C

source $ZINIT[HOME_DIR]/bin/zinit.zsh

zinit wait lucid light-mode for \
	atload"_zsh_autosuggest_start" \
	    zsh-users/zsh-autosuggestions \
	blockf atpull'zinit creinstall -q .' \
	    zsh-users/zsh-completions

zinit lucid light-mode for \
  zinit-zsh/z-a-bin-gem-node \
  zinit-zsh/z-a-patch-dl \
  Aloxaf/fzf-tab


zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':completion:complete:*:options' sort false


zinit from"gh-r" sbin"direnv" mv"direnv* -> direnv" \
	atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
	src="zhook.zsh" for \
	direnv/direnv

zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" \
	    zdharma/fast-syntax-highlighting
