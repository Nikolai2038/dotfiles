#!/bin/bash

function main() {
  if pgrep --exact --full waybar > /dev/null; then
    echo "Hiding waybar..." >&2
    pkill --exact --full waybar || return "$?"
    echo "Hiding waybar: success!" >&2
  else
    echo "Showing waybar..." >&2
    waybar &
    echo "Showing waybar: success!" >&2
  fi
}

main "$@" || exit "$?"
