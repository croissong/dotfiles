mkcd () {
    case "$1" in
        */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
        /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
        /*) mkdir -p "$1" && cd "$1";;
        */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
        ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
        *) mkdir -p "./$1" && cd "./$1";;
    esac
}

tmux-update-env () {
    for key in SSH_AUTH_SOCK SSH_CONNECTION DISPLAY; do
        if (tmux show-environment | grep "^${key}" > /dev/null); then
            value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
            export ${key}="${value}"
        fi
    done
}
