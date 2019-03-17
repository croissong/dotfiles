if [ -z "$TMUX" ]; then
    tmux attach-session -d
else
    setopt extendedglob
    autoload -Uz compinit
    for dump in $ZDOTDIR/.zcompdump(N.mh+24); do
        compinit
    done

    compinit -C

    autoload -Uz promptinit
    promptinit
    setopt COMPLETE_ALIASES
    DISABLE_AUTO_UPDATE=true

    source $ZDOTDIR/.zsh_plugins.sh
    source $MY_DOTFILES/env/profile
    source ~/.tmuxinator/tmuxinator.zsh
    setopt GLOBDOTS
    setopt PROMPT_SP
    setopt AUTO_PARAMSLASH
    setopt AUTOCD
    setopt SHARE_HISTORY
    setopt HIST_IGNORE_DUPS
    setopt HIST_FIND_NO_DUPS
    AGKOZAK_BLANK_LINES=1
    AGKOZAK_LEFT_PROMPT_ONLY=1

    export FZF_DEFAULT_COMMAND='fd --type f'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="fd -t d -d 5"
    export ENHANCD_FILTER=fzf

    source /usr/share/fzf/key-bindings.zsh
    source /usr/share/fzf/completion.zsh
    source $ZDOTDIR/zsh_overrides.zsh

    zstyle ':completion:*' insert-tab false
fi
