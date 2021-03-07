#!/usr/bin/env bash

minutesLeft=`pomodoro status -f '%R'`
if [ "$minutesLeft" = "0" ]; then
    state=Idle
else
    state=Info
fi
echo "{\"icon\": \"POMODORO\", \"state\": \"$state\", \"text\": \"$minutesLeft\"}"
