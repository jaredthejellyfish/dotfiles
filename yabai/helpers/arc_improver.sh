#!/bin/bash

all_windows=$(yabai -m query --windows)

arc_running=$(echo $all_windows | jq -r '.[] | .app' | grep -c "Arc")
if [[ $arc_running == 0 ]]; then
  exit 0
fi

arc_space=$(echo $all_windows | jq -r '.[] | select(.app == "Arc") | .space')
other_apps_in_arc_space=$(echo "$all_windows" | jq -r --arg arc_space "$arc_space" '.[] | select(.space == ($arc_space|tonumber) and .app != "Arc" and (.["is-minimized"] | not) and (."is-floating" | not)) | .app')

if [[ $other_apps_in_arc_space != "" ]]; then
  yabai -m space $arc_space --padding abs:15:25:25:25
else
  yabai -m space $arc_space --padding abs:30:45:80:80
fi

exit 0
