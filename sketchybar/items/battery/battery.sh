#!/bin/bash

battery=(
  script="$PLUGIN_DIR/battery.sh"
  update_freq=90
  updates=on
  icon.font="SF Pro:Regular:17.0"
  label.font="$FONT:Semibold:13.0"
  label.drawing=no
  padding_right=13
  label.padding_left=8
  click_script="sketchybar --set battery label.drawing=toggle"
)

sketchybar --add item battery right \
  --set battery "${battery[@]}" \
  --subscribe battery \
  power_source_change \
  system_woke \
  mouse.clicked \
  mouse.entered \
  mouse.exited
