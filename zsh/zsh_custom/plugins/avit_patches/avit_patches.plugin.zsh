get_current_dir () {
    local _long_pwd_length="90"
    local _medium_pwd_length="50"
    local _len=$(echo -n $PWD | wc -c)
    if [[ ${_len} -gt ${_long_pwd_length} ]]; then
        echo "%{$fg[blue]%}$(shrink_path -t -5 -e '..')%{$reset_color%} "
    elif [[ ${_len} -gt ${_medium_pwd_length} ]]; then
        echo "%{$fg[blue]%}$(shrink_path -f -5 -e '..')%{$reset_color%} "
    else
        echo "%{$fg[blue]%}%~%{$reset_color%} "
    fi
}

precmd() {
    x=$(print -P '%-1(?..1')
    if [ ! -z $x ]; then
        echo ""
    fi
}

PROMPT=$(sed -e '/./,$!d' <<< ${PROMPT/'${_current_dir}'/'$(get_current_dir)'})
