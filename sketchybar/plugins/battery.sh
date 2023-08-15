#!/bin/bash

BATTERY_INFO="$(pmset -g batt)"
PERCENTAGE=$(echo "$BATTERY_INFO" | grep -Eo "\d+%" | cut -d% -f1)
if echo "$BATTERY_INFO" | grep -q "Now drawing from 'AC Power'"; then CHARGING=on; else CHARGING=off; fi

if [ $PERCENTAGE = "" ]; then
  exit 0
fi

if [[ $CHARGING == "on" ]]; then
  battery_icon=(
    icon.drawing=on
    drawing=on
    icon="􀢋"
    label="$PERCENTAGE%"
  )
  sketchybar --set battery "${battery_icon[@]}"
  exit 0
fi

COLOR=$GREEN
case ${PERCENTAGE} in
9[0-9] | 100)
  ICON=􀛨
  ;;
[6-8][0-9])
  ICON="􀺸"
  ;;
[3-5][0-9])
  ICON="􀺶"
  ;;
[1-2][0-9])
  ICON="􀛩"
  COLOR=$ORANGE
  ;;
*)
  ICON="􀛪"
  COLOR=$RED
  ;;
esac

battery_icon=(
  icon.drawing=on
  drawing=on
  icon=$ICON
  label="$PERCENTAGE%"
)

sketchybar --set battery "${battery_icon[@]}"
