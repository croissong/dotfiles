#!/usr/bin/env bash

krew list >"$DOT/dotfiles/dot_config/krew/plugins.txt"
echo "Wrote $DOT/dotfiles/dot_config/krew/plugins.txt" >&2
git --no-pager -C "$DOT/dotfiles" diff dot_config/krew/plugins.txt

# import: krew install < $DOT/dotfiles/dot_config/krew/plugins.txt
