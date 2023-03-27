#!/usr/bin/env bash
kubectl krew list >"${DOT}/dot_config/krew/plugins.txt"
echo "Wrote ${DOT}/dot_config/krew/plugins.txt" >&2
git -C "$DOT" diff dot_config/krew/plugins.txt
