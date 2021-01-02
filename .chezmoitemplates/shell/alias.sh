alias ls='exa -gha --group-directories-first'
alias cat=bat
alias find='fd -H'
alias feh='feh --conversion-timeout 1 -g 640x480 -d -S filename'
alias top=htop
alias open=mimeo
alias history='history -E'

alias df='df -h -P --total --exclude-type=devtmpfs 2>/dev/null'
alias clip='wl-copy'
alias du='dust -b'
alias journalctl='journalctl -fxe'
alias pass=gopass
alias passc='gopass show -c'
alias passo='gopass otp -c'
alias ssh='TERM=xterm ssh'

alias lock='physlock -ds'

alias ec=emacsclient
man() {emacsclient -que "(progn (man \"$1\") (select-frame-set-input-focus (selected-frame)))"}

alias kc=kubectl
alias kcd='kubectl config set-context $(kubectl config current-context) --namespace'
alias kctx='kubectl config use-context'
alias kcg='kubectl get -o yaml'
alias kcdsc='kubectl describe'
alias kcroll='kubectl rollout restart'
alias kcl='kubectl logs -f --tail 100'
alias kcx='kubectl exec -ti'
alias kcfwd='kubectl port-forward'
alias kcw='kubectl get po -w -owide'
alias kcgs='kubectl get -owide --sort-by=.metadata.creationTimestamp'

alias tw='task'
alias twa='task add'
alias twl='task list'
alias twd='task done'
alias twm='task modify'

alias docker=podman
alias summon='cyberark-summon -f summon.yml'
alias unpack=aunpack
alias pack=apack
alias c=z
alias vpnio='sudo swanctl -i -c vpn'

alias mvnpkg='mvn package -DskipTests'
alias mvndep='mvn dependency:resolve -Dclassifier=sources'

alias gitdelbr="git branch -vv | grep ': gone]' | grep -v '\*' | awk '{ print $1}' | xargs -r git branch -D"

alias curlwbench='curl -H "PRIVATE-TOKEN: `pass show svh/gitlab-token`" --cert $HOME/.config/svh/ssl_smarthub-wbench/user.crt --key $HOME/.config/svh/ssl_smarthub-wbench/userkey.pem'

awkp() { awk "{print \$${1:-1}}"; }
