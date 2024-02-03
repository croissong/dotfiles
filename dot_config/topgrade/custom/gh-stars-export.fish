#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

# only run once a day
if string length --quiet (fd --changed-within 1d gh-stars.txt)
    echo "gh-stars.txt last modfied less than 1d ago (at $(date '+%H:%M' -r gh-stars.txt)) - exiting"
    exit
end

gh api --paginate user/starred --template '{{range .}}{{.full_name}} - {{.description}} {{"\n"}}{{end}}' >gh-stars.txt

echo "Wrote Github stars export to $DOT/priv/gh-stars.txt" >&2

commitIfChanged gh-stars.txt
