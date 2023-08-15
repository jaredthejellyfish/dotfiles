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
  label="Not playing..."
  icon.color=0xc9ffffff
  drawing=on
  padding_right=12
  label.color=0xc9ffffff
  label.font="$FONT:Semibold:13.0"
  background.color=0xff393939
  background.drawing=on
  background.corner_radius=4
  background.height=28
  icon.padding_left=6
  icon.padding_right=5
  label.padding_right=8
)

sketchybar --add event spotify_change $SPOTIFY_EVENT \
  --add item spotify.anchor e \
  --set spotify.anchor "${spotify_anchor[@]}" \
  --subscribe spotify.anchor mouse.entered mouse.exited spotify_change mouse.clicked
