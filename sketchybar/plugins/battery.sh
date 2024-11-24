#!/bin/bash

function update {

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
      icon.color=0xffffffff
      label.color=0xffffffff
    )
    sketchybar --set battery "${battery_icon[@]}"
    exit 0
  fi

  COLOR=0xffffffff
  case ${PERCENTAGE} in
  9[0-9] | 100)
    ICON=􀛨
    ;;
  [6-8][0-9])
    ICON=􀺸
    ;;
  [3-5][0-9])
    ICON=􀺶
    ;;
  [1-2][0-9])
    ICON=􀛩
    COLOR=0xfff5a97f
    ;;
  *)
    ICON=􀛪
    COLOR=0xffed8796
    ;;
  esac

  battery_icon=(
    icon.drawing=on
    icon=$ICON
    label="$PERCENTAGE%"
    icon.color=$COLOR
    label.color=$COLOR
  )

  sketchybar --set battery "${battery_icon[@]}"
}

case "$SENDER" in
"mouse.clicked")
  sketchybar --set battery label.drawing=toggle
  ;;
*)
  update
  ;;
esac
