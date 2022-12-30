#!/usr/bin/env bash

export VERSION="$1"
echo "https://github.com/${OWNER}/${REPO}/${URLPATH}" | envsubst
