#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

the-way export >snippets.json
echo "Wrote the-way snippets to $DOT/priv/snippets.json" >&2

commitIfChanged snippets.json

# import: the-way import snippets.json
