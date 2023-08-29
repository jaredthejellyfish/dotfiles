#!/bin/bash

switch_anchor=(
  popup.horizontal=on
  popup.height=130
  icon="􀠀"
  icon.font="$FONT:Regular:14.5"
  icon.color=0xffff9024 #0xc9ffffff
  icon.padding_left=3
  icon.padding_right=2
  y_offset=0.25
  background.color=0x02393939
  blur_radius=3
  background.drawing=on
  background.corner_radius=4
  background.height=25
  script="$ITEM_DIR/switch/scripts/switch_get_state.sh"
  padding_right=2
  update_freq=30
)



sketchybar --add item switch q \
  --set switch "${switch_anchor[@]}" \
  --subscribe switch mouse.clicked mouse.entered mouse.exited
