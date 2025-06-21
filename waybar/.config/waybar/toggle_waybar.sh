#!/bin/bash

function main() {
  if pgrep --exact --full waybar > /dev/null; then
    echo "Hiding waybar..." >&2
    pkill --exact --full waybar || return "$?"
    echo "Hiding waybar: success!" >&2

    # Because waybar is responsible for bottom gap, we recalculate it here
    hyprctl dispatch exec "hyprctl keyword general:gaps_out 4,4,4,4"
  else
    echo "Showing waybar..." >&2
    waybar &
    echo "Showing waybar: success!" >&2

    # Because waybar is responsible for bottom gap, we recalculate it here
    hyprctl dispatch exec "hyprctl keyword general:gaps_out 4,4,0,4"
  fi
}

main "$@" || exit "$?"
