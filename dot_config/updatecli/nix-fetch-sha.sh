#!/usr/bin/env bash

URL="$1"

if [[ "$URL" == *"/archive/refs"* ]] || [[ "$URL" == *".zip" ]]; then
  nix-prefetch-url --unpack "$URL"
else
  nix-prefetch-url "$URL"
fi
