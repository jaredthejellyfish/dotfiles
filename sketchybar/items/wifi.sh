#!/bin/bash

wifi=(
  padding_right=12
  update_freq=5
  script="$PLUGIN_DIR/wifi.sh"
  icon.font="$FONT:Semibold:14.5"
)

sketchybar --add item wifi right \
  --set wifi "${wifi[@]}" \
  --subscribe wifi \
  wifi_change \
  mouse.clicked \
  mouse.entered \
  mouse.exited
