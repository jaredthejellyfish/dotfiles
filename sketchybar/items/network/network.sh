network_down=(
  y_offset=-6
  label.font="SF Mono:Heavy:10"
  label.color="$WHITE"
  icon="􀆈"
  icon.font="SF Mono:Bold:12"
  icon.color="$GREEN"
  icon.highlight_color="$BLUE"
  update_freq=1
  icon.padding_right=8
  padding_right=16
)

network_up=(
  icon.padding_right=8
  background.padding_right=-69
  y_offset=6
  label.font="SF Mono:Heavy:10"
  label.color="$WHITE"
  icon="􀆇"
  icon.font="SF Mono:Bold:12"
  icon.color="$GREEN"
  icon.highlight_color="$BLUE"
  update_freq=1
  script="$ITEM_DIR/network/scripts/network.sh"
)

sketchybar --add item network.down right \
  --set network.down "${network_down[@]}" \
  --add item network.up right \
  --set network.up "${network_up[@]}"
