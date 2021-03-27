alias ls='exa -gha --group-directories-first'
alias ll='ls -l'

alias cat=bat
alias less=bat
function tail() { /usr/bin/tail -f "$@" | bat --paging=never -l log }

alias find='fd -H'
alias feh='feh --conversion-timeout 1 -g 640x480 -d -S filename'
alias top=btm
alias open='handlr open'
alias history='history -E'
alias tree=br
alias ps=procs
alias sed=sd
alias ntop='sudo nethogs'
alias rename=vidir
alias diff=delta

alias df='df -h -P --total --exclude-type=devtmpfs 2>/dev/null'
alias clip='wl-copy'
alias du='dust -b'
alias journalctl='journalctl -fxe'
alias pass=gopass
alias passc='gopass show -c'
alias passo='gopass otp -c'
alias ssh='TERM=xterm ssh'

alias lock='physlock -ds'

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
alias kcrollall="kc get deploy --no-headers=true -ocustom-columns='name:{.metadata.name}' | xargs -I{} kubectl rollout restart deploy {}"

alias tw='task'
alias twa='task add'
alias twl='task list'
alias twd='task done'
alias twm='task modify'

alias docker=podman
alias summon='summon -f summon.yml'
alias vpnio='sudo swanctl -i -c vpn'

alias pets='pet search | clip'

alias vol=pamixer
alias volg='pamixer --get-volume-human'

alias mvnpkg='mvn package -DskipTests'
alias mvndep='mvn dependency:resolve -Dclassifier=sources'

alias lights='sudo light -S'
alias lightskbd='lights -s sysfs/leds/tpacpi::kbd_backlight'

alias curlwbench='curl -H "PRIVATE-TOKEN: `pass show svh/gitlab-token`" --cert $HOME/.config/svh/ssl_smarthub-wbench/user.crt --key $HOME/.config/svh/ssl_smarthub-wbench/userkey.pem'

awkp() { awk "{print \$${1:-1}}"; }

b64e() { echo -n $1 | base64 -w0 }
b64d() { echo -n $1 | base64 -d }

e() {
    if [ -z "$1" ]; then
        TMP="$(mktemp /tmp/stdin-XXX)"
        cat >$TMP
        emacsclient $TMP
        rm $TMP
    else
        emacsclient "$@"
    fi
}

function pgrep() { /usr/bin/pgrep "$@" | xargs --no-run-if-empty ps fp; }
