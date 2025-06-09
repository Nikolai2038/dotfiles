#!/bin/bash

function main() {
  local profile
  profile="$(powerprofilesctl get)" || return "$?"

  if [ "${profile}" = "power-saver" ]; then
    brightnessctl set 25% || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-1, 1920x1080@60, 0x0, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-2, 1920x1080@60, 1920x0, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'eDP-2, 1920x1080@60, 3840x0, 1'" || return "$?"
  elif [ "${profile}" = "balanced" ]; then
    brightnessctl set 50% || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-1, 1920x1080@60, 0x0, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-2, 2560x1440@60, 1920x-360, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'eDP-2, 2560x1440@60, 4480x0, 1.6'" || return "$?"
  elif [ "${profile}" = "performance" ]; then
    brightnessctl set 100% || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-1, 1920x1080@144, 0x0, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'DP-2, 2560x1440@175, 1920x-360, 1'" || return "$?"
    hyprctl dispatch exec "hyprctl keyword monitor 'eDP-2, 2560x1440@165, 4480x0, 1.6'" || return "$?"
  fi
}

main "$@" || exit "$?"
