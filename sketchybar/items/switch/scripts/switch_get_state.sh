#!/bin/bash

ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ENV_DIR/.env"

# Run curl command and save result
result=$(curl -s \
  -H "Authorization: Bearer $HOME_ASSISTANT_API_KEY" \
  -H "Content-Type: application/json" \
  https://3c1bxumldeemc2fhbplo5mky3erdm8z2.ui.nabu.casa/api/states/switch.office_grow_light)

if [[ $(echo "$result" | jq -r '.state') == "on" ]]; then
  sketchybar -m --set switch icon.color=0xffff9024
else
  sketchybar -m --set switch icon.color=0xc9ffffff
fi
