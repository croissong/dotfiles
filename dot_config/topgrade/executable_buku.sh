#!/usr/bin/env bash
folder="$1"
buku -p -j "${folder}/buku.json"
jq '[.[] | .["url"] = .uri | .["name"] = .title | del(.uri, .title, .tags, .index, .description)]' "${folder}/buku.json" >"${folder}/buku-firefox-nix.json"
