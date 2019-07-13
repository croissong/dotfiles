source $MY_DOTFILES/env/profile
tmuxinator start home
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  startx
fi
