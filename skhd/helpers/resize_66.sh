window=$(yabai -m query --windows --window)

echo $window
split_child=$(echo $window | jq '."split-child"')

if [ "$split_child" == "null" ]; then
    exit 0
fi

if [ "$split_child" == "\"first_child\"" ]; then
    yabai -m window --ratio abs:0.65
    exit 0
fi

if [ "$split_child" == "\"second_child\"" ]; then
    yabai -m window --ratio abs:0.32
    exit 0
fi
