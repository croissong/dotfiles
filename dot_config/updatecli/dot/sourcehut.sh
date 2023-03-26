#!/usr/bin/env bash
set -xeo pipefail

read OWNER REPO ASSET < <(echo $(jq -r '.owner, .repo, .asset' <<<$1))

VERSION=$(
    curl --fail -s -H "Authorization: token $SH_TOKEN" \
        "https://git.sr.ht/api/${OWNER}/repos/${REPO}/refs" |
        jq -r '.results[-1].name' |
        sd 'refs/tags/(.*)' '$1'
)

eval "ASSET=$ASSET" # substitute ${VERSION}
url="https://git.sr.ht/${OWNER}/${REPO}/refs/download/${VERSION}/${ASSET}"
sha=$(./dot/nix-fetch-sha.sh $url)
echo "'{version: \"$VERSION\", url: \"$url\", sha: \"$sha\"}'"
