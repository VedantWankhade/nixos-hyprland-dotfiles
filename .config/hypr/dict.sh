#!/usr/bin/env bash
echo key ctrl+c | dotool
word=$(wl-paste)
meaning=$(dict "$word")
notify-send "$word" "$meaning"

