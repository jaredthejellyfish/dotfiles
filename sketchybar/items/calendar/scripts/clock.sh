#!/bin/bash

# Get current date
current_time=$(date +"%T")

# Extract the last number
last_number=${current_time: -1}

# Check if the last number is odd
if (( $last_number % 2 != 0 ))
then
    # Replace colons with empty unicode characters
    current_time=${current_time//:/"'"}
fi

# Run the SketchyBar command
sketchybar --set clock label="$current_time"
