export PATH=$PATH:$GOPATH/bin:.node_modules/bin:

if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
    startx
fi
