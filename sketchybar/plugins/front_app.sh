#  run the following line only if the $BUTTON variable is equal to "left"
if [ "$BUTTON" = "left" ]; then
  yabai -m window --toggle zoom-fullscreen
else
  yabai -m window --toggle float
fi
