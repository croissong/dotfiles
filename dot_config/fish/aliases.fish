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

alias sy=systemctl-tui
alias sys=systemctl
alias sysu='sys --user'
alias journ='journalctl -fxe -u'
alias journu='journalctl -fxe --user -u'

alias gpgt=gpg-tui
alias tf=terraform
alias jq=gojq
alias spot=spotify_player
alias dl='curl --create-dirs -O --output-dir /tmp/'
alias pkill='pkill -f -e'

alias steam='steam -nofriendsui -no-browser +open "steam://open/minigameslist"'
alias weather='wthrr'

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

alias jwtd='jwt decode -j --date=Local'

function man
    emacsclient -que "(progn (man \"$1\") (select-frame-set-input-focus (selected-frame)))"
end

#
# Kubectl
#

alias k=kubectl
alias kf=kubectl-fuzzy

# TODO: back to kubie?^^
alias kc='switch --show-preview=false'
alias kcc='kc h'
alias kk="kubectl config view --minify -o jsonpath='{.contexts[0].context.cluster} {.contexts[0].context.namespace}{\"\n\"}'"
# alias kn='switch ns'
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

alias cal='khal'
alias call='cal list'
alias cala='cal calendar'
alias cali='ikhal'

alias b64e='sttr base64-encode'
alias b64d='sttr base64-decode'

alias cert-view='step certificate inspect'

alias susp='systemctl suspend'

alias nixs='nix-search'
alias nixsd='nix-search -d -n '

function pickcolor
    grim -g "$(slurp -p)" -t ppm - |
        convert - -format '%[pixel:p{0,0}]' txt:- |
        awk -F ' ' 'NR==2 {print $3}'
end

function e
    if [ -z "$1" ]
        set TMP "$(mktemp /tmp/stdin-XXX)"
        cat >$TMP
        emacsclient -n $TMP
        rm $TMP
    else
        emacsclient -n "$argv"
        fi
    end
end

alias j='just --unstable --justfile ~/.user.justfile --working-directory .'

function ts-from-unix
    date --utc -Iseconds -d @$1
end

function ts-to-unix
    date -d "$1" +"%s"
end

function ts-now-s
    date +'%s'
end

function reload
    unset __HM_SESS_VARS_SOURCED
    source $__fish_config_dir/config.fish
end
