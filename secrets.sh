#!/usr/bin/env bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
if [ "$1" == "secrets" ]; then
  sops -d --output-type=json $SCRIPT_DIR/secrets.yml
elif [ "$1" == "tf" ]; then
  sops -d --output-type=json $SCRIPT_DIR/tf/secrets-output.yml
fi
