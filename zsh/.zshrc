if [ -z "$TMUX" ]; then
    tmux attach-session -d
else
    setopt extendedglob
    autoload -Uz compinit
    # TODO ZDOTDIR
    if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
	            compinit;
              else
	                compinit -C;
          fi;

              autoload -Uz promptinit
              promptinit
              setopt COMPLETE_ALIASES

              ZSH_THEME=""
              # ZSH_CUSTOM=$HOME/dotfiles/zsh/zsh_custom
              ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
              DISABLE_AUTO_UPDATE=true
              source <(antibody init)

              antibody bundle < ~/dotfiles/zsh/antibody/.zsh_plugins.txt
              # antibody bundle $HOME/dotfiles/zsh/zsh_custom/plugins/shrink-path
              # antibody bundle $HOME/dotfiles/zsh/zsh_custom/plugins/avit_patches
              source ~/dotfiles/.env/profile
              source ~/.tmuxinator/tmuxinator.zsh
              setopt globdots
              setopt PROMPT_SP
              setopt auto_paramslash
              setopt autocd
              AGKOZAK_BLANK_LINES=1
              source /usr/share/fzf/key-bindings.zsh
              source /usr/share/fzf/completion.zsh

              zstyle ':completion:*' insert-tab false
          fi
