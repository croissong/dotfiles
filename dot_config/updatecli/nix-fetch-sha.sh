#!/usr/bin/env bash

URL="$1"

if [[ "$URL" == *"/archive/refs"* ]]; then
  nix-prefetch-url --unpack "$URL"
else
  nix-prefetch-url "$URL"
fi
