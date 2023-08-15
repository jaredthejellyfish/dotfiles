#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
POPUP_SCRIPT="sketchybar -m --set spotify.anchor popup.drawing=toggle"

spotify_anchor=(
  script="$PLUGIN_DIR/spotify.sh"
  click_script="$POPUP_SCRIPT"
  popup.horizontal=on
  popup.height=130
  icon=󰓇
  icon.font="$ICONS_FONT:Regular:20.0"
  label.drawing=off
  drawing=on
  padding_right=12
)

sketchybar --add event spotify_change $SPOTIFY_EVENT \
  --add item spotify.anchor right \
  --set spotify.anchor "${spotify_anchor[@]}" \
  --subscribe spotify.anchor mouse.entered mouse.exited
