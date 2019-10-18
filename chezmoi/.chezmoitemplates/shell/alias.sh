alias unpack=dtrx
alias pack='tar zcvf'

alias ls='exa -gha --group-directories-first'
# https://github.com/b4b4r07/enhancd/issues/104
# alias find='fd -H'
alias feh='feh --conversion-timeout 1 -g 640x480 -d -S filename'
alias top=glances
alias open=mimeo

alias df='df -h -P --total --exclude-type=devtmpfs 2>/dev/null'
alias clip='xclip -sel c'
alias dud='du -hd1'
alias journalctl='journalctl -fxe'
alias curl='curl -s'
alias pass=gopass
alias ssh='TERM=xterm ssh'
alias summon='cyberark-summon -f $MY_PRIV/summons/secrets.yml'

alias lock='physlock -ds'

alias rg='rg --color always --no-heading --smart-case --hidden --ignore-file $HOME/.config/ripgrep/ignore'

alias ediff='scripts emacsc_ediff'
alias ediff3='scripts emacsc_ediff3'

alias kc=kubectl
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace '
alias kctx='kubectl config use-context'
alias kcg='kubectl get -o yaml'
alias kcdesc='kubectl describe'
alias kcroll='kubectl patch deployment -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"'
alias kcl='kubectl logs -f'

alias tw='task'
alias twa='task add'
alias twl='task list'
alias twd='task done'
alias twm='task modify'
