#!/usr/bin/env fish

cd $DOT/priv
git --no-pager log origin/master..HEAD
git push
