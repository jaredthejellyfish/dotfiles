#!/usr/bin/env bash

CAL_PLUGIN_DIR="$ITEM_DIR/calendar/scripts"

clock=(
  label.font="SF Mono:Semibold:13.0"
  update_freq=1
  script="$CAL_PLUGIN_DIR/clock.sh"
  click_script="$CAL_PLUGIN_DIR/click.sh"
  label.color=$WHITE
  width=65
)

sketchybar --add item clock right \
  --set clock "${clock[@]}" \
  --subscribe clock system_woke
