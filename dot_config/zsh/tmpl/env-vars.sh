HISTORY_IGNORE="(ls *|pwd)"
HISTTIMEFORMAT="%d.%m.%y %T "
HISTFILE=$XDG_CONFIG_HOME/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000


# Treat these characters as part of a word.
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'


export SUMMON_PROVIDER=/usr/bin/gopass-summon-provider
export LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export GOPASS_NO_NOTIFY=true
