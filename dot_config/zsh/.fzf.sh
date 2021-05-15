export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d -d 5"

zinit wait lucid light-mode binary from"gh-r" for \
    sbin"fzf" \
        atdelete"rm -vf $ZPFX/man/man1/fzf.1" \
        dl"https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh; \
            https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh;
            https://raw.githubusercontent.com/junegunn/fzf/master/man/man1/fzf.1 -> $ZPFX/man/man1/fzf.1" \
        multisrc"completion.zsh key-bindings.zsh" \
        junegunn/fzf
