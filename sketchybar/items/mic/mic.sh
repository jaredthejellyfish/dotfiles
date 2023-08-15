#!/bin/bash

mic_anchor=(
  popup.horizontal=on
  popup.height=130
  icon=􀊱
  icon.font="$FONT:Regular:17.0"
  label.drawing=off
  icon.color=0xc9ffffff
  icon.padding_left=6
  icon.padding_right=10
  background.color=0xff393939
  background.drawing=on
  background.corner_radius=4
  background.height=28
  click_script="$ITEM_DIR/mic/scripts/mic_click.sh"
  padding_right=-2
)

sketchybar --add item mic q \
  --set mic "${mic_anchor[@]}" \
  --subscribe mic mouse.clicked
