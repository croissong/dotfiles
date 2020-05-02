#!/bin/env bash
emacsclient -q --eval '(org-babel-tangle-file (expandenv "$DOTFILES/src/snippets.org") (expandenv "$HOME/.local/bin/snippets"))'
