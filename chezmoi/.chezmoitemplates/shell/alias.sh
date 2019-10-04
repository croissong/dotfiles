alias unpack=dtrx
alias pack='tar zcvf'

alias ls='exa -gha --group-directories-first'
alias find='fd -H'
alias feh='feh --conversion-timeout 1 -g 640x480 -d -S filename'
alias top=glances
alias open=mimeo

alias lock='physlock -ds'

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
