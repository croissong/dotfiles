# https://zsh.sourceforge.io/Doc/Release/Options.html

setopt AUTO_PARAM_SLASH

# https://unix.stackexchange.com/questions/308315/how-can-i-configure-zsh-completion-to-show-hidden-files-and-folders
setopt GLOB_DOTS

setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_FUNCTIONS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY

unsetopt nomatch
