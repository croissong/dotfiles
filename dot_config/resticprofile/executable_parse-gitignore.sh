#!/usr/bin/env bash

set -ueo pipefail

file="$1"
dir="$2"

if grep -q '[^[:space:]]' "$file"; then
  rg --color=never '^/?([^\s#].*)$' -r "$dir"'/**/$1' "$file"
fi
