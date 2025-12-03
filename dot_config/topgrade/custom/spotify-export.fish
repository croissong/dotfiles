#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

set token (oauth2c https://accounts.spotify.com/ \
    --client-id (pass show -o ent/spotify/client id) \
    --response-types code \
    --response-mode query \
    --grant-type authorization_code \
    --auth-method none \
    --scopes playlist-read-private,playlist-read-collaborative,user-library-read \
    --pkce --redirect-url http://127.0.0.1:43019/callback -s | jq -r '.access_token')

spotify-backup spotify.txt --token=$token --dump=liked

echo "Wrote spotify export to $DOT/priv/spotify.txt" >&2

commitIfChanged spotify.txt "spotify export"
