#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/gooogle-chrome-unstable
EDITOR=/usr/bin/emacs
# <<< END ADDED BY CNCHI INSTALLER
TERMINAL=/usr/bin/urxvt
