#!/usr/bin/env bash

set -ueo pipefail

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
excludes_file="${SCRIPT_DIR}/generated-excludes.txt"

rm "$excludes_file"

# https://forum.restic.net/t/skipping-git-ignored-files/4638
# https://github.com/borgbackup/borg/issues/641
fd -H '\.gitignore' ~/code ~/.config ~/dot \
	-E 'golang' -E 'nixpkgs' \
	-x rg --color=never '^/?([^\s#].*)$' -r {//}'/**/$1' {} \
	>"$excludes_file"

lines=$(wc -l <"$excludes_file")

if [ "$lines" -gt 500 ]; then
	echo "$lines lines in generated-excludes.txt"
else
	echo "generated-excludes.txt has too few lines ($lines)."
	exit 1
fi
