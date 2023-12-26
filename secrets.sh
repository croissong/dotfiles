#!/usr/bin/env bash
if [ "$1" == "secrets" ]; then
  sops -d --output-type=json secrets.yml
elif [ "$1" == "tf" ]; then
  sops -d --output-type=json tf/secrets-output.yml
fi
