#!/usr/bin/env bash

the-way export > "${DOT}/priv/snippets.json"
echo "Wrote ${DOT}/priv/snippets.json" >&2
git --no-pager -C "$DOT/priv" diff snippets.json
