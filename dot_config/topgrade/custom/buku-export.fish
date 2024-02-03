#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

echo y | buku --nostdin -e buku.md
echo "Wrote buku export to $DOT/priv/buku.md" >&2

commitIfChanged buku.md

buku -p -j | jq '[.[] |
select( .tags | contains("no-export-ff") | not) |
.["url"] = .uri |
.["name"] = .title |
del(.uri, .title, .tags, .index, .description)
]' >"$DOT/system/nix-config/bookmarks.json"

echo "Wrote buku bookmarks to $DOT/system/nix-config/bookmarks.json" >&2


# import: buku -i buku.md
