alias kc=kubectl
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace '
alias kctx='kubectl config use-context'
alias kcg='kubectl get -o yaml'
alias kcd='kubectl describe'
alias kcroll='kubectl patch deployment -p \
  "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"'
