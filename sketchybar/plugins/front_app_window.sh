#!/bin/bash

WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.title')
WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -d " " -f 1)
# List of application names to disable for
disabled_apps=("Finder" "Terminal" "iTerm2" "Sketchybar" "Brave Browser")

# Check if $INFO matches any of the names in the list
for app_name in "${disabled_apps[@]}"; do
  if [[ $INFO = "$app_name" ]]; then
    case $app_name in
      *)
      sketchybar -m --set front_app_window label.drawing=off icon.drawing=off
      ;;
    esac
    exit 0
  fi
done

if [[ $WINDOW_TITLE = "" ]]; then
  sketchybar -m --set front_app_window label.drawing=off icon.drawing=off
  exit 0
fi

if [[ ${#WINDOW_TITLE} -gt 10 ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-50)
  sketchybar -m --set front_app_window label.drawing=on icon.drawing=on label="$WINDOW_TITLE"
  exit 0
fi

sketchybar -m --set front_app_window label.drawing=on icon.drawing=on label="$WINDOW_TITLE"
