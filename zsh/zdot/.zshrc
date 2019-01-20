if [ -z "$TMUX" ]; then
    tmux attach-session -d
else
    setopt extendedglob
    autoload -Uz compinit
    if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
	            compinit;
              else
	                compinit -C;
          fi;
              autoload -Uz promptinit
              promptinit
              setopt COMPLETE_ALIASES
              DISABLE_AUTO_UPDATE=true

              source $ZDOTDIR/.zsh_plugins.sh
              source ~/dotfiles/.env/profile
              source ~/.tmuxinator/tmuxinator.zsh
              setopt globdots
              setopt PROMPT_SP
              setopt auto_paramslash
              setopt autocd
              setopt inc_append_history
              AGKOZAK_BLANK_LINES=1

              export FZF_DEFAULT_COMMAND='fd --type f'
              export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
              export FZF_ALT_C_COMMAND="fd -t d -d 5"
              export ENHANCD_FILTER=fzf

              source /usr/share/fzf/key-bindings.zsh
              source /usr/share/fzf/completion.zsh

              zstyle ':completion:*' insert-tab false
          fi
