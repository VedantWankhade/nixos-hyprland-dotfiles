#!/usr/bin/env bash
echo this is dict
echo key ctrl+C | dotool
word=$(wl-paste)
meaning=$(dict "$word")
notify-send "$word" "$meaning"

