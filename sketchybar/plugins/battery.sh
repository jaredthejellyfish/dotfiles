#!/bin/bash

source "$CONFIG_DIR/icons.sh"
source "$CONFIG_DIR/colors.sh"

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(echo "$BATTERY_INFO" | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

DRAWING=on
COLOR=$WHITE
case ${PERCENTAGE} in
  9[0-9]|100) ICON=􀛨; DRAWING=off
  ;;
  [6-8][0-9]) ICON=􀺸; DRAWING=off
  ;;
  [3-5][0-9]) ICON=􀺶
  ;;
  [1-2][0-9]) ICON=􀛩; COLOR=$ORANGE
  ;;
  *) ICON=􀛪; COLOR=$RED
esac

if [[ $CHARGING != "" ]]; then
  ICON=􀢋
  DRAWING=off
fi

sketchybar --set $NAME drawing=$DRAWING icon="$ICON" icon.color=$COLOR label="$PERCENTAGE%"
