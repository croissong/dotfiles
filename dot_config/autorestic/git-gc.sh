#!/usr/bin/env bash

# fd -H --type directory -E 'golang' -E '.local' -E .cache -E tmp '\.git$' ~/ --exec echo '{//}'

fd -H --type directory \
  -E 'golang' -E '.local' -E .cache -E tmp \
  '\.git$' ~/ \
  --exec git -C '{//}' gc

fd -H --type directory \
  -E 'golang' -E '.local' -E .cache -E tmp \
  '\.git$' ~/ \
  --exec git -C '{//}' submodule foreach git gc
