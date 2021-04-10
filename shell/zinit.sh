declare -A ZINIT
ZINIT[HOME_DIR]=$XDG_CONFIG_HOME/zsh/.zinit

source $ZINIT[HOME_DIR]/bin/zinit.zsh

zinit for \
    light-mode zsh-users/zsh-autosuggestions \
    light-mode zsh-users/zsh-completions \
    light-mode zdharma/fast-syntax-highlighting
