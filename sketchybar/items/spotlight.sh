#!/bin/bash

spotlight=(
  icon="􀊫"
  icon.font="$FONT:Semibold:13.5"
  padding_right=28
  click_script="osascript -e 'tell application \"System Events\" to keystroke \" \" using {command down}'"
)

sketchybar --add item spotlight right \
  --set spotlight "${spotlight[@]}" \
