#!/usr/bin/env bash
cd ${DOT}/priv

the-way export >snippets.json
echo "Wrote the-way snippets to ${DOT}/priv/snippets.json" >&2

if [[ -n $(git status --porcelain snippets.json) ]]; then
  git --no-pager diff snippets.json
  git add snippets.json
  git commit -m "chore: update snippets"
  echo "snippets.json changes committed" >&2
else
  echo "No changes detected in snippets.json" >&2
fi
