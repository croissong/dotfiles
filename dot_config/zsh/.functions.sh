ediff3() {
  if [ $# -ne 3 ]; then
    echo Usage: $0 local base other
    exit 1
  fi
  emacsclient -c -q --eval '(ediff-merge-with-ancestor "'$1'" "'$2'" "'$3'")'
}


# https://github.com/junegunn/fzf/wiki/Examples#processes
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}
