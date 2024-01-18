HISTORY_IGNORE="(ls *|pwd)"
HISTTIMEFORMAT="%d.%m.%y %T "
HISTFILE=$XDG_CONFIG_HOME/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000

# For some reason this gives the best effect
# from https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
WORDCHARS=

export SUMMON_PROVIDER=$(which gopass-summon-provider)
