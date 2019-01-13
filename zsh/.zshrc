gpg-connect-agent updatestartuptty /bye >/dev/null

ZSH_THEME="avit"
ZSH_CUSTOM=$HOME/dotfiles/zsh/zsh_custom
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
DISABLE_AUTO_UPDATE=true
source <(antibody init)
antibody bundle < ~/dotfiles/zsh/antibody/.zsh_plugins.txt
antibody bundle $HOME/dotfiles/zsh/zsh_custom/plugins/shrink-path
antibody bundle $HOME/dotfiles/zsh/zsh_custom/plugins/avit_patches

source ~/dotfiles/.env/profile
source ~/.tmuxinator/tmuxinator.zsh
setopt globdots
[[ -z "$TMUX" ]] && tmux attach-session -d
