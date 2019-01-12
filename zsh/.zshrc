source ~/dotfiles/.env/vars
gpg-connect-agent updatestartuptty /bye >/dev/null

ZSH_THEME="avit"
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
DISABLE_AUTO_UPDATE=true
source <(antibody init)
antibody bundle < ~/dotfiles/zsh/antibody/.zsh_plugins.txt

source ~/.tmuxinator/tmuxinator.zsh

# setopt nosharehistory

[[ -z "$TMUX" ]] && tmux attach-session -d
