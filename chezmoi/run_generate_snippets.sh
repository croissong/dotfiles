#!/bin/env bash
emacsclient -q --eval '(org-babel-tangle-file (format "%s/chezmoi/src/snippets.org" (getenv "MY_DOTFILES")) "$HOME/.local/bin/snippets")'
