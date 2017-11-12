export PATH=$PATH:$GOPATH/bin:$NODE_MODULES_PATH/bin

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    startx
fi
