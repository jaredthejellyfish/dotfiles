#!/bin/bash

update() {
  PLAYING=1
  if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name | sed 's/\(.\{20\}\).*/\1.../')"
    ARTIST="$(echo "$INFO" | jq -r .Artist | sed 's/\(.\{20\}\).*/\1.../')"
    COVER=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
  fi
  label="$TRACK"

  if [ "$PLAYING" = "1" ]; then
    TRACK="Nothing playing"
    ARTIST=""
    COVER=""
  fi

  #If it is playing then we need to run some sketchybar commands
  if [ "$PLAYING" = "0" ]; then
    sketchybar -m --set spotify.anchor icon.color=0xff1ed761 label="$label" label.drawing=on background.color=0x39393939
    sleep 1
    sketchybar -m --set spotify.anchor icon.color=0xff1ed761 label="$label" label.drawing=off background.color=0x03393939
  fi

  if [ "$PLAYING" = "1" ]; then
    sketchybar -m --set spotify.anchor icon.color=0xc9ffffff label.drawing=off label="Not playing..."
  fi

}

hover() {
    sketchybar -m --set spotify.anchor label.drawing=toggle
}

case "$SENDER" in
"mouse.clicked")
  osascript -e 'tell application "Spotify" to next track'
  ;;
"mouse.entered")
   sketchybar -m --set spotify.anchor label.drawing=on blur_radius=90
  ;;
"mouse.exited")
   sketchybar -m --set spotify.anchor label.drawing=off blur_radius=3
  ;;
"forced")
  exit 0
  ;;
*)
  update
  ;;
esac
