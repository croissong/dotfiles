#!/usr/bin/env bash
cd ${DOT}/priv

gh api --paginate user/starred --template '{{range .}}{{.full_name}} - {{.description}} {{"\n"}}{{end}}' >"gh-stars.txt"

echo "Wrote Github stars export to ${DOT}/priv/gh-stars.txt" >&2

if [[ -n $(git status --porcelain "gh-stars.txt") ]]; then
  git --no-pager diff gh-stars.txt
  git add gh-stars.txt
  git commit -m "chore: update Github stars"
  echo "gh-stars.txt changes committed" >&2
else
  echo "No changes detected in gh-stars.txt" >&2
fi
