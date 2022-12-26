alias ls='exa -ga --group-directories-first'
alias ll='ls -l'
alias l='xplr'

alias cat=bat
alias b=bat
alias less=bat
alias q=pueue
function tail() { /usr/bin/tail -f "$@" | bat --paging=never -l log; }

alias rt='trash put'

alias find='fd -H'
alias top=btm
alias topgrade='topgrade --show-skipped'
alias open='handlr open'
alias history='history -E 0 | tac | cat'
alias tree=br
alias x=xplr
alias ps=procs
alias dig=dog
alias sed=sd
alias ntop='sudo nethogs'
alias rename=vidir
alias diff=delta
alias m=neomutt
alias mr='neomutt -R'
alias ms='mailsync'
alias watch='viddy'
alias sys=sysz
alias sy=systemctl
alias syu='sy --user'
alias gpgt=gpg-tui
alias tf=terraform

alias weather='curl v2.wttr.in'

alias mani='mani -c ~/.config/mani/code.yaml'
alias mani-all='cm apply ~/.config/mani && mani run rm && mani sync'

alias cm='chezmoi'

alias myip='dig -1 myip.opendns.com @resolver1.opendns.com'

alias ec=echo

alias nix='nix --extra-experimental-features "nix-command flakes"'

alias printer='system-config-printer'

alias df='duf'
alias clip='wl-copy -n'
alias du='dust -b'
# todo https://github.com/junegunn/fzf/issues/2028
alias pass=gopass
alias p="gopass ls --flat | fzf  --bind 'enter:execute-silent(gopass -c {})+abort,alt-enter:execute-silent(gopass -c {}),alt-#:execute-silent(gopass otp -c {})+abort,space:execute(gopass show {})+abort,alt-+:execute-silent(choose -f / -1 <<< {} | wl-copy -n)'"
alias ssh='TERM=xterm ssh'

alias ag='angle-grinder -o json'

alias pack='ouch compress'
alias unpack='ouch decompress'

alias paruch='paru --config ~/.config/pacman/chaotic-aur.conf'

alias jwtd='jwt decode -j --iso8601'

man() {emacsclient -que "(progn (man \"$1\") (select-frame-set-input-focus (selected-frame)))"}

#
# Kubectl
#

alias k=kubectl
alias kf=kubectl-fuzzy

alias ktxrm='k config delete-context'
alias ktxmv='k config rename-context'

alias kk='k delete'
alias kkf='kf delete'

alias kg='k neat get -o yaml'
alias kgr='k get -o yaml'

alias kd='k describe'
alias kdf='kf describe'

alias ke='k edit'
alias kroll='k rollout restart'

alias kl='k stern -n $(kubesess -c namespace) -t --container-state running,waiting,terminated'

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

alias pets='pet search | clip'

alias vol=pamixer
alias volg='pamixer --get-volume-human'

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

b64e() { echo -n $(cat -) | base64 -w0; }
b64d() { echo -n $(cat -) | base64 -d; }

alias cert-view='step certificate inspect'

alias promotor='~/.cache/pypoetry/virtualenvs/promotor-M1X4eowa-py3.10/bin/promotor'

alias journalctl='journalctl -fxe'
alias susp='systemctl suspend'

alias netd-restart='systemctl restart systemd-networkd systemd-resolved iwd'
alias netd-journal='journalctl -u systemd-networkd -u systemd-resolved -u iwd'

alias nixs='nix search nixpkgs'

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

function pgrep() { /usr/bin/pgrep "$@" | xargs --no-run-if-empty ps fp; }

alias j='just --justfile ~/.user.justfile --working-directory .'
alias jpriv='just --justfile ~/.user-priv.justfile --working-directory .'

ts-from-unix() {
  date --utc -Iseconds -d @$1
}

ts-to-unix() {
  date -d "$1" +"%s"
}

ts-now-s() {
  date +'%s'
}

# https://github.com/guibou/nixGL
alias imv='nixGL imv'
