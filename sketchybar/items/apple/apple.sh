apple_logo=(
  icon=􀣺
  icon.font="$FONT:Black:16.0"
  icon.color=$WHITE
  label.drawing=off
  click_script="$POPUP_CLICK_SCRIPT"
  popup.height=35
  padding_left=3
  y_offset=-1
)


sketchybar --add item apple.logo left \
  --set apple.logo "${apple_logo[@]}" \
