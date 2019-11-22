#!/bin/env bash
emacsclient -q --eval '(org-babel-tangle-file (format "%s/src/snippets.org" (getenv "MY_DOTFILES")) (format "%s/.local/bin/snippets" (getenv "HOME")))'
