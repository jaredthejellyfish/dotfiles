#!/bin/bash

ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ENV_DIR/.env"

# define the update function in the following lines
function update {
  # Run curl command and save result
  result=$(curl -s \
    -H "Authorization: Bearer $HOME_ASSISTANT_API_KEY" \
    -H "Content-Type: application/json" \
    $HOME_ASSISTANT_URL/api/states/switch.office_grow_light)

  if [[ $(echo "$result" | jq -r '.state') == "on" ]]; then
    sketchybar -m --set switch icon.color=0xffff9024
  else
    sketchybar -m --set switch icon.color=0xc9ffffff
  fi
}

function click {
  exec >/dev/null 2>&1

  curl \
    -H "Authorization: Bearer $HOME_ASSISTANT_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"entity_id": "switch.office_grow_light"}' \
    $HOME_ASSISTANT_URL/api/services/switch/toggle

  update

}

case "$SENDER" in
"mouse.clicked")
  click
  ;;
*)
  update
  ;;
esac
