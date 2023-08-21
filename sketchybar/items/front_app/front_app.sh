#!/bin/bash

FRONT_APP_SCRIPT='[ "$SENDER" = "front_app_switched" ] && sketchybar --set $NAME label="$INFO"'

front_app=(
  icon.drawing=off
  label.font="$FONT:Bold:14.0"
  label.padding_left=20
  associated_display=active
  script="$FRONT_APP_SCRIPT"
  click_script="$PLUGIN_DIR/front_app.sh"
  y_offset=-1
)

front_app_window=(
  icon="􀆂"
  icon.padding_left=8
  label.font="$FONT:Bold:13.0"
  icon.font="$FONT:Bold:11.0"
  icon.color=0xf2ababab
  label.color=0xffc9c9c9
  label.padding_left=8
  associated_display=active
  script="$PLUGIN_DIR/front_app_window.sh"
  update_freq=5

)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched mouse.clicked

sketchybar --add item front_app_window left \
  --set front_app_window "${front_app_window[@]}" \
  --subscribe front_app_window front_app_switched
