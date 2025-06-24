#!/bin/bash

function main() {
  if systemctl --user status waybar.service &> /dev/null; then
    echo "Hiding waybar..." >&2
    systemctl --user stop waybar.service || return "$?"
    echo "Hiding waybar: success!" >&2

    # Because waybar is responsible for bottom gap, we recalculate it here
    hyprctl dispatch exec "hyprctl keyword general:gaps_out 4,4,4,4"
  else
    echo "Showing waybar..." >&2
    systemctl --user start waybar.service || return "$?"
    echo "Showing waybar: success!" >&2

    # Because waybar is responsible for bottom gap, we recalculate it here
    hyprctl dispatch exec "hyprctl keyword general:gaps_out 4,4,0,4"
  fi
}

main "$@" || exit "$?"
