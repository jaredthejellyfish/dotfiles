#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  update_freq=90
  updates=on
  icon.font="SF Pro:Regular:17.0"
  label.font="$FONT:Semibold:12.0"
  label.drawing=yes
  padding_right=10
  label.padding_left=8
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery \
  power_source_change \
  system_woke \
  mouse.clicked \
