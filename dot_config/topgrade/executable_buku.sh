#!/usr/bin/env bash
cd ${DOT}/priv

buku -p -j "buku.json"
echo "Wrote buku export to ${DOT}/priv/buku.json" >&2

jq '[.[] | select( .tags | contains("no-export-ff") | not) | .["url"] = .uri | .["name"] = .title | del(.uri, .title, .tags, .index, .description)]' "${DOT}/priv/buku.json" >"${DOT}/priv/buku-firefox-nix.json"

if [[ -n $(git status --porcelain "buku.json") ]]; then
  git --no-pager diff buku.json
  git add "buku.json"
  git commit -m "chore: update buku bookmarks"
  echo "buku.json changes committed" >&2
else
  echo "No changes detected in buku.json" >&2
fi
