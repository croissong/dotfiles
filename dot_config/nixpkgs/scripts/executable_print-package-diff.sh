#!/usr/bin/env bash

diff -u ~/tmp/packages-prev.txt ~/tmp/packages.txt |
  delta --color-only --24-bit-color=never --paging never --raw \
    >&2
cp -f ~/tmp/packages.txt ~/tmp/packages-prev.txt
