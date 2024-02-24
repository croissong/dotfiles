#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

spotify-backup spotify.txt --dump=liked

echo "Wrote spotify export to $DOT/priv/spotify.txt" >&2

commitIfChanged spotify.txt "spotify export"
