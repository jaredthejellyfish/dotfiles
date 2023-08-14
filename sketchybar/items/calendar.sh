#!/bin/bash

calendar_script=$(cat <<'EOL'
  icon="$(date '+%a %d %b')"
  label="$(date '+%H:%M:%S')"
  sketchybar --set calendar icon="$icon" label="$label"
EOL
)

calendar=(
  icon.font="$FONT:Semibold:13.0"
  icon.padding_right=8
  label.font="$FONT:Semibold:13.0"
  padding_left=15
  update_freq=1
  script="$calendar_script"
  click_script="osascript -e 'tell application \"System Events\" to keystroke \"n\" using {option down, control down}'"
)

sketchybar --add item calendar right \
  --set calendar "${calendar[@]}" \
  --subscribe calendar system_woke
