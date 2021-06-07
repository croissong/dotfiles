#!/usr/bin/env bash

minutesLeft=`pomodoro status -f '%r'`
if [ "$minutesLeft" = "0:00" ]; then
    text=""
else
    text="$minutesLeft"
fi
echo "{\"icon\": \"pomodoro\", \"text\": \"$text\"}"
