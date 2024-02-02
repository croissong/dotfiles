#!/usr/bin/env fish
cd $DOT/priv

echo y | buku --nostdin -e buku.md
echo "Wrote buku export to $DOT/priv/buku.md" >&2

if string length --quiet (git status --porcelain buku.md)
    git --no-pager diff buku.md
    git add buku.md
    git commit -m "chore: update buku bookmarks"
    echo "buku.md changes committed" >&2
else
    echo "No changes detected in buku.md" >&2
end



buku -p -j | jq '[.[] |
select( .tags | contains("no-export-ff") | not) |
.["url"] = .uri |
.["name"] = .title |
del(.uri, .title, .tags, .index, .description)
]' >"$DOT/system/nix-config/bookmarks.json"

echo "Wrote buku bookmarks to $DOT/system/nix-config/bookmarks.json" >&2


# import: buku -i buku.md
