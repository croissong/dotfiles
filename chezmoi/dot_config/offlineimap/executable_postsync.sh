#!/usr/bin/env bash
if pgrep -f 'mu server'; then
  emacsclient -e '(mu4e-update-index)'
else
  mu index --maildir ~/mail
fi
