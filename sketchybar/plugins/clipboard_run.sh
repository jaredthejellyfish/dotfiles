#!/bin/bash

json_file="/tmp/clipboard_storage.json"

# read .clipboard property from json file
get_clipboard() {
  jq -r '.clipboard[]' $json_file
}

# read the file and store it in a variable
clipboard=$(get_clipboard '.')

# if the clipboard is empty, exit
if [ -z "$clipboard" ]; then
  exit 0
fi

# Assign the clipboard items to an array
IFS=$'\n' read -rd '' -a items <<<"$clipboard"

# If the length is 1, then just echo the first item
if [ "${#items[@]}" -eq 1 ]; then
  echo "${items[0]}"
  exit 0
fi

# If the length is greater than 1, then print the items with a number
if [ "${#items[@]}" -gt 1 ]; then
  index=0
  for item in "${items[@]}"; do
    echo "$index $item"
    ((index++))
  done
  exit 0
fi
