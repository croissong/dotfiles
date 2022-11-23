#!/usr/bin/env bash
folder="$1"
buku -p -j "${folder}/buku.json"
jq '[.[] | select( .tags | contains("no-export-ff") | not) | .["url"] = .uri | .["name"] = .title | del(.uri, .title, .tags, .index, .description)]' "${folder}/buku.json" >"${folder}/buku-firefox-nix.json"
