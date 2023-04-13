#!/usr/bin/env bash
folder="$DOT/priv"
buku -p -j "${DOT}/priv/buku.json"
echo "Wrote ${DOT}/priv/buku.json" >&2
jq '[.[] | select( .tags | contains("no-export-ff") | not) | .["url"] = .uri | .["name"] = .title | del(.uri, .title, .tags, .index, .description)]' "${DOT}/priv/buku.json" >"${DOT}/priv/buku-firefox-nix.json"
git --no-pager -C "${DOT}/priv" diff buku.json
