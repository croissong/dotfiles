#!/usr/bin/env bash

set -ueo pipefail

excludes_file="/tmp/generated-excludes.txt"

rm -f "$excludes_file"

script_dir=$(dirname "$0")

# https://forum.restic.net/t/skipping-git-ignored-files/4638
# https://github.com/borgbackup/borg/issues/641

fd -H '\.gitignore' ~/code ~/.config ~/dot \
	-E 'golang' -E 'nixpkgs' \
	-x "$script_dir"/parse-gitignore.sh {} {//} \
	>"$excludes_file"

lines=$(wc -l <"$excludes_file")

if [ "$lines" -gt 500 ]; then
	echo "$lines lines in generated-excludes.txt"
else
	echo "generated-excludes.txt has too few lines ($lines)."
	exit 1
fi
