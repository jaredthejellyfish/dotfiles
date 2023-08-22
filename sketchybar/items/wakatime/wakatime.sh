#!/bin/bash

wakatime=(
  padding_right=12
  y_offset=-1
  icon.font="$FONT:Semibold:14"
  script="$ITEM_DIR/wakatime/scripts/get_digital.sh"
  label.font="$FONT:Semibold:13"
  label.padding_left=10
  icon=􀐱
  update_freq=5
  click_script="open https://wakatime.com/dashboard"
)

sketchybar --add item wakatime right \
  --set wakatime "${wakatime[@]}" \