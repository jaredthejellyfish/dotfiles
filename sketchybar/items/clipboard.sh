#!/bin/bash

POPUP_CLICK_SCRIPT="sketchybar --set clipboard popup.drawing=toggle"

clipboard=(
  script="python3 $PLUGIN_DIR/clipboard.py"
  update_freq=5
  updates=on
  icon=􀉃
  popup.drawing=off
  popup.background.color=$BAR_COLOR
  align=right
  blur_radius=1000
  background.padding_right=15
  click_script="python3 $PLUGIN_DIR/clipboard.py && $POPUP_CLICK_SCRIPT"
  icon.font="$FONT:Regular:14.0"

)

sketchybar --add item clipboard right \
  --set clipboard "${clipboard[@]}" \
  --add item clipboard.template left popup.clipboard mouse.exit
