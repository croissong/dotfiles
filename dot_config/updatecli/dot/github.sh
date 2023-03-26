#!/usr/bin/env bash
set -xeo pipefail

read OWNER REPO ASSET TRIM_PREFIX < <(echo $(jq -r '.owner, .repo, .asset, .trimPrefix' <<<$1))
VERSION="$2"

if [ "$TRIM_PREFIX" == true ]; then
    VERSION_PREFIX="v"
fi

if [ "$ASSET" != false ]; then
    eval "ASSET=$ASSET" # substitute ${VERSION}
    url="https://github.com/${OWNER}/${REPO}/releases/download/${VERSION_PREFIX}${VERSION}/${ASSET}"
else
    url="https://github.com/${OWNER}/${REPO}/archive/refs/tags/${VERSION_PREFIX}${VERSION}.tar.gz"
fi

sha=$(./dot/nix-fetch-sha.sh "$url")

echo "'{version: \"$VERSION\", url: \"$url\", sha: \"$sha\"}'"
