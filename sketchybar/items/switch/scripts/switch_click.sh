ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ENV_DIR/.env"

exec > /dev/null 2>&1

curl \
  -H "Authorization: Bearer $HOME_ASSISTANT_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"entity_id": "switch.office_grow_light"}' \
  $HOME_ASSISTANT_URL/api/services/switch/toggle

bash "$(dirname "$0")/switch_get_state.sh"
