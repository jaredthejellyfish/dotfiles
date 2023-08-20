ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ENV_DIR/.env"

exec > /dev/null 2>&1

curl \
  -H "Authorization: Bearer $HOME_ASSISTANT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.office_grow_light"}' \
  https://3c1bxumldeemc2fhbplo5mky3erdm8z2.ui.nabu.casa/api/services/switch/toggle
