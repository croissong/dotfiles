#!/usr/bin/env bash

rm -f /tmp/excludes.txt

# https://github.com/borgbackup/borg/issues/641
fd -H '\.gitignore' ~/code ~/.config ~/Dot ~/System \
  -E 'golang' \
  -x rg --color=never '^/?([^\s#].*)$' -r {//}'/**/$1' {} \
  >/tmp/excludes.txt

lines=$(cat /tmp/excludes.txt | wc -l)
tput setaf 4
echo "Added $lines lines to excludes"
