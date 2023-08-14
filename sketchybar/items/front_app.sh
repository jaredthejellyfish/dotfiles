#!/bin/bash

FRONT_APP_SCRIPT='[ "$SENDER" = "front_app_switched" ] && sketchybar --set $NAME label="$INFO"'

front_app=(
  icon.drawing=off
  label.font="$FONT:Bold:14.0"
  label.padding_left=20
  associated_display=active
  script="$FRONT_APP_SCRIPT"
  click_script="$PLUGIN_DIR/front_app.sh"
)

sketchybar --add item front_app left \
  --set front_app "${front_app[@]}" \
  --subscribe front_app front_app_switched
