#!/bin/bash

SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"

spotify_anchor=(
  script="$PLUGIN_DIR/spotify.sh"
  icon=󰓇
  icon.font="$ICONS_FONT:Regular:19"
  label.drawing=off
  label="Not playing..."
  icon.color=0xc9ffffff
  background.padding_left=3
  y_offset=-0.15
  label.color=0xc9ffffff
  label.font="$FONT:Semibold:13.0"
  background.color=0x02393939
  blur_radius=3
  background.drawing=on
  background.corner_radius=4
  background.height=25
  icon.padding_left=4
  icon.padding_right=7
  label.padding_right=8
)

sketchybar --add event spotify_change $SPOTIFY_EVENT \
  --add item spotify.anchor e \
  --set spotify.anchor "${spotify_anchor[@]}" \
  --subscribe spotify.anchor mouse.entered mouse.exited spotify_change mouse.clicked
