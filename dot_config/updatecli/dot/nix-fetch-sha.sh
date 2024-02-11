#!/usr/bin/env bash

URL="$1"

if [[ "$URL" == *"/archive/refs"* ]] || [[ "$URL" == *".zip" ]]; then
  /run/current-system/sw/bin/nix-prefetch-url --unpack "$URL"
else
  /run/current-system/sw/bin/nix-prefetch-url "$URL"
fi
