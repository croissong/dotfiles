#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

the-way export >snippets.json
echo "Wrote the-way snippets to $DOT/priv/snippets.json" >&2

commitIfChanged snippets.json "the-way snippets"

# import: the-way import snippets.json
