#!/usr/bin/env bash


rm -f /tmp/excludes.txt

# https://github.com/borgbackup/borg/issues/641
fd -H '\.gitignore' ~/code \
   -E 'golang' \
   -E 'tmp' \
   -x rg --color=never '^/?([^\s#].*)$' -r {//}'/$1' {} \
   > /tmp/excludes.txt

fd -H '\.gitmodules' ~/code \
   -E 'golang' \
   -E 'tmp' \
   -x bash -c 'git config --file {} --get-regexp path | choose 1 | rg --color=never "(.*)" -r {//}/\$1' \
   >> /tmp/excludes.txt

lines=`cat /tmp/excludes.txt | wc -l`
tput setaf 4; echo "Added $lines lines to excludes"
