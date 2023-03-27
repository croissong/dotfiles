#!/usr/bin/env bash

the-way export > "${DOT}/priv/snippets.json"
echo "Wrote ${DOT}/priv/snippets.json" >&2
git -C "$DOT/priv" diff snippets.json
