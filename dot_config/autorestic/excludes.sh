#!/usr/bin/env bash

set -uo pipefail

rm -f /tmp/excludes.txt

# https://forum.restic.net/t/skipping-git-ignored-files/4638

# https://github.com/borgbackup/borg/issues/641
fd -H '\.gitignore' ~/code ~/.config ~/dot \
	-E 'golang' \
	-x rg --color=never '^/?([^\s#].*)$' -r {//}'/**/$1' {} \
	>/tmp/excludes.txt

lines=$(cat /tmp/excludes.txt | wc -l)
tput setaf 4
echo "Added $lines lines to excludes"
