#!/usr/bin/env bash
gh api --paginate user/starred --template '{{range .}}{{.full_name}} - {{.description}} {{"\n"}}{{end}}' > "${DOT}/priv/gh-stars.txt"
git --no-pager -C "${DOT}/priv" diff gh-stars.txt
