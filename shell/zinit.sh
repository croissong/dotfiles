declare -A ZINIT
ZINIT[HOME_DIR]=$XDG_CONFIG_HOME/zsh/.zinit

source $ZINIT[HOME_DIR]/bin/zinit.zsh

zinit for \
    light-mode zinit-zsh/z-a-bin-gem-node \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode zdharma/fast-syntax-highlighting

zinit from"gh-r" sbin"direnv" mv"direnv* -> direnv" \
    atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
    src="zhook.zsh" for \
        direnv/direnv
