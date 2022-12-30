#!/usr/bin/env bash

export VERSION="$1"

if  [ "$TRIM_PREFIX" != false ]; then
  VERSION_PATH="v${VERSION}"
else
  VERSION_PATH="$VERSION"
fi

if  [ "$ASSET" != false ]; then
  echo "https://github.com/${OWNER}/${REPO}/releases/download/${VERSION_PATH}/${ASSET}" | envsubst
else
  echo "https://github.com/${OWNER}/${REPO}/archive/refs/tags/${VERSION_PATH}.tar.gz"
fi
