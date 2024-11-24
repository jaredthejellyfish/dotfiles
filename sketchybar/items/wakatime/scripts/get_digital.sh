ENV_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ENV_DIR/.env"

function update {
    digital=$(curl "https://wakatime.com/api/v1/users/current/status_bar/today?api_key=$WAKATIME_API_KEY" 2>/dev/null | jq -r '.data.grand_total.digital')

    # Extract the first number from the string using awk
    first_number=$(echo "$digital" | awk -F':' '{print $1}')

    # Check if the first number is not greater than 5
    if [[ -n "$first_number" && "$first_number" -le 5 ]]; then
        color="0xffffffff"
    else
        color="0xffed8796"
    fi

    sketchybar -m --set wakatime label=$digital icon.color=$color
}

function click {
    sketchybar --set wakatime label.drawing=toggle
}

case "$SENDER" in
"mouse.clicked")
    click
    ;;
*)
    update
    ;;
esac
