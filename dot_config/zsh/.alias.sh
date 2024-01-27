alias ls='eza -ga --group-directories-first'
alias ll='ls -l'
alias l='xplr'

alias cat=bat
alias q=pueue

alias rt='gtrash put'
alias rm="echo -e 'use rt'; false"

alias find='fd -H'
alias top=btm
alias topgrade='topgrade --show-skipped'
alias open='handlr open'
alias history='history -E 0 | tac | cat'
alias tree='eza --tree'
alias x=xplr
alias ps=procs
alias dig=dog
alias sed=sd
alias ntop='sudo nethogs'
alias rename=vidir
alias diff=difft
alias m=neomutt
alias mr='neomutt -R'
alias ms='mailsync'
alias watch='viddy'
alias sys=sysz
alias sy=systemctl
alias syu='sy --user'
alias gpgt=gpg-tui
alias tf=terraform
alias jq=gojq
alias spot=spotify_player
alias dl='curl --create-dirs -O --output-dir /tmp/'

alias steam='steam -nofriendsui -no-browser +open "steam://open/minigameslist"'
alias weather='wthrr'

alias mani='mani -c ~/.config/mani/code.yaml'
alias mani-all='cm apply ~/.config/mani && mani run rm && mani sync'

alias cm='chezmoi'

alias myip='dig -1 myip.opendns.com @resolver1.opendns.com'

alias ec=echo
alias cg='cd $(git root)'

alias printer='system-config-printer'

alias df='duf'
alias clip='wl-copy -n'
alias du='dust -b'
alias pass=gopass

alias ag='angle-grinder -o json'

alias pack='ouch compress'
alias unpack='ouch decompress'

alias paruch='paru --config ~/.config/pacman/chaotic-aur.conf'

alias jwtd='jwt decode -j --date=Local'

man() {emacsclient -que "(progn (man \"$1\") (select-frame-set-input-focus (selected-frame)))"}

#
# Kubectl
#

alias k=kubectl
alias kf=kubectl-fuzzy

alias kc='switch --show-preview=false'
alias kcc='kc h'
alias kk="kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster} {.contexts[0].context.namespace}{\"\n\"}'"
alias kn='switch ns'
alias kcrm='k --kubeconfig ~/.kube/config config delete-context'
alias kcmv='k --kubeconfig ~/.kube/config config rename-context'

alias kg='k get -o yaml'
alias kgn='k neat get -o yaml'

alias kd='k describe'
alias kdf='kf describe'

alias ke='k edit'
alias kroll='k rollout restart'

alias kl='stern --timestamps=short'
alias klj='stern --template-file ~/.config/stern/stern.tpl'

alias kx='k exec -ti'
alias kxf='kf exec -ti'

alias kfwd='k port-forward'
alias kw='k get po -w -owide | rg'
alias kgs='k get -owide --sort-by=.metadata.creationTimestamp'

#
#
#

alias tw='task'
alias twa='task add'
alias twl='task list'
alias twd='task done'
alias twm='task modify'

alias godeps='go get -u all && go mod tidy'

alias docker=podman
alias summon='summon -f summon.yml'

alias ways='the-way search'
alias wayn='the-way new'

alias mvnpkg='mvn package -DskipTests'
alias mvndep='mvn dependency:resolve -Dclassifier=sources'
alias mvntree='mvn dependency:tree | tee /tmp/tree.txt'
alias mvnpom='mvn help:effective-pom | tee /tmp/pom.xml'
alias mvnupdate='mvn versions:dependency-updates-report -DprocessDependencyManagementTransitive=false && chromium target/site/dependency-updates-report.html'

alias curl=curlie
alias curll='/usr/bin/curl'

alias cal='khal'
alias call='cal list'
alias cala='cal calendar'
alias cali='ikhal'

alias aconfmgr='aconfmgr --skip-checksums --aur-helper paru'
alias parus="paru -Slq | fzf --multi --preview 'paru -Si {1}' | clip"

alias pacdiff='sudo -E pacdiff'

alias emacsmin='emacs -q --load ~/.config/emacs/init-minimal.el'

awkp() { awk "{print \$${1:-1}}"; }

alias b64e='sttr base64-encode'
alias b64d='sttr base64-decode'

alias cert-view='step certificate inspect'

alias promotor='~/.cache/pypoetry/virtualenvs/promotor-M1X4eowa-py3.10/bin/promotor'

alias journalctl='journalctl -fxe'
alias susp='systemctl suspend'

alias netd-restart='systemctl restart systemd-networkd systemd-resolved iwd'
alias netd-journal='journalctl -u systemd-networkd -u systemd-resolved -u iwd'

alias nixs='nix-search'
alias nixsd='nix-search -d -n '

function pickcolor() {
  grim -g "$(slurp -p)" -t ppm - |
    convert - -format '%[pixel:p{0,0}]' txt:- |
    awk -F ' ' 'NR==2 {print $3}'
}

e() {
  if [ -z "$1" ]; then
    TMP="$(mktemp /tmp/stdin-XXX)"
    cat >$TMP
    emacsclient -n $TMP
    rm $TMP
  else
    emacsclient -n "$@"
  fi
}

alias j='just --unstable --justfile ~/.user.justfile --working-directory .'

ts-from-unix() {
  date --utc -Iseconds -d @$1
}

ts-to-unix() {
  date -d "$1" +"%s"
}

ts-now-s() {
  date +'%s'
}

function reload() {
  unset __HM_SESS_VARS_SOURCED
  source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  # TODO
  # source $ZDOTDIR/.zshrc
}
