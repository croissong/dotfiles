#!/usr/bin/env bash

set -ueo pipefail

fd -H --type directory \
	-E 'golang' -E '.local' -E .cache -E tmp -E nixpkgs \
	'\.git$' ~/ \
	--exec git -C '{//}' gc --auto

fd -H --type directory \
	-E 'golang' -E '.local' -E .cache -E tmp -E nixpkgs \
	'\.git$' ~/ \
	--exec git -C '{//}' submodule foreach git gc --auto
