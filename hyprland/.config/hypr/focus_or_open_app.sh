#!/bin/bash

function main() {
  local class_name="${1}" && shift

  if [ "$(hyprctl dispatch focuswindow "class:^(${class_name})\$")" = "No such window found" ]; then
    # # This for some reason not moving focus, when executing this script in "bind" (or as "hyprctl dispatch exec ~/.config/hypr/focus_or_open_app.sh").
    # # So instead, I use "windowrule" for apps.
    # hyprctl dispatch workspace 101 || return "$?"

    uwsm app -- "${class_name}.desktop" || return "$?"
  fi
}

main "$@" || exit "$?"
