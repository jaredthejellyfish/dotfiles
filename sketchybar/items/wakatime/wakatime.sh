#!/bin/bash

wakatime=(
  padding_right=12
  y_offset=-1
  icon.font="$FONT:Semibold:14"
  script="$ITEM_DIR/wakatime/scripts/get_digital.sh"
  label.font="$FONT:Semibold:13"
  icon.padding_right=5
  label.padding_left=5
  icon=􀐱
  update_freq=5
)

sketchybar --add item wakatime right \
  --set wakatime "${wakatime[@]}" \
  --subscribe wakatime \
  mouse.clicked \
