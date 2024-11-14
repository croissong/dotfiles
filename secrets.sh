#!/usr/bin/env bash

if [ "$1" == "secrets" ]; then
  sops -d --output-type=json "${DOT}/priv/dot/secrets.yml"
elif [ "$1" == "tf" ]; then
  sops -d --output-type=json "${DOT}/priv/tf-secrets-output.yml"
fi
