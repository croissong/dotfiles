set -a
.  <(systemctl --user show-environment)
set +a
export ZDOTDIR=$MY_DOTFILES/zsh/zdot
