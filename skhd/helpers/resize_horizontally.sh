window=$(yabai -m query --windows --window)

echo $window
split_child=$(echo $window | jq -r '."split-child"')

if [ "$split_child" == "null" ]; then
    exit 0
fi

if [ "$split_child" == "first_child" ]; then
    yabai -m window --resize right:-150:0
    exit 0
fi

if [ "$split_child" == "second_child" ]; then
    yabai -m window --resize left:150:0
    exit 0
fi