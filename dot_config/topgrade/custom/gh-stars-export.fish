#!/usr/bin/env fish
source (status dirname)/lib.fish
cd $DOT/priv

# only run once a day
if string length --quiet (fd --changed-within 7d gh-stars.txt)
    echo "gh-stars.txt last modfied less than 7d ago (at $(date '+%d.%m' -r gh-stars.txt)) - exiting"
    exit
end

gh api --paginate user/starred --template '{{range .}}{{.full_name}} - {{.description}} {{"\n"}}{{end}}' >gh-stars.txt

echo "Wrote Github stars export to $DOT/priv/gh-stars.txt" >&2

commitIfChanged gh-stars.txt "Github stars"
