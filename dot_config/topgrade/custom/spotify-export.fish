#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

exportify-cli --config ~/.config/exportify-cli/config.cfg -a --output ~/dot/priv/spotify-playlists

echo "Wrote spotify export to $DOT/priv/spotify-playlists" >&2

commitIfChanged spotify-playlists "spotify export"
