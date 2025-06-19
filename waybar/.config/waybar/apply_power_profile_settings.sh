#!/bin/bash

function change_monitor() {
  local monitor="$1" && shift
  local params="$1" && shift

  # If specified monitor is connected
  if hyprctl monitors | grep -q "^Monitor ${monitor}"; then
    # Change it's settings
    hyprctl dispatch exec "hyprctl keyword monitor '${monitor}, ${params}'" || return "$?"

    # Wait until Hyprland reconfigure the monitor.
    # If we do not wait, other monitors will wrongly set their positions.
    local iterations=0
    while ! hyprctl monitors | grep -q "^Monitor ${monitor}"; do
      sleep 0.1

      ((iterations++))
      if [ "${iterations}" -gt 30 ]; then
        break
      fi
    done
  fi
}

function main() {
  local profile
  profile="$(powerprofilesctl get)" || return "$?"

  # Update config file
  cp "${HOME}/.config/hypr/hyprland.conf.d/.05_power_${profile}.conf" ~/.config/hypr/hyprland.conf.d/05_power.conf || return "$?"

  # Change the monitors by script, because "hyprctl reload" does not correctly wait for them to turn on.
  if [ "${profile}" = "power-saver" ]; then
    change_monitor "DP-1" "1920x1080@60, 0x0, 1.0" || return "$?"
    change_monitor "DP-2" "1920x1080@60, 1920x0, 1" || return "$?"
    change_monitor "eDP-2" "1920x1080@60, 3840x0, 1" || return "$?"
  elif [ "${profile}" = "balanced" ]; then
    change_monitor "DP-1" "1920x1080@60, 0x0, 1.0" || return "$?"
    change_monitor "DP-2" "2560x1440@60, 1920x-360, 1.0" || return "$?"
    change_monitor "eDP-2" "2560x1440@60, 4480x0, 1.6" || return "$?"
  elif [ "${profile}" = "performance" ]; then
    change_monitor "DP-1" "1920x1080@144, 0x0, 1.0" || return "$?"
    change_monitor "DP-2" "2560x1440@175, 1920x-360, 1.0" || return "$?"
    change_monitor "eDP-2" "2560x1440@165, 4480x0, 1.6" || return "$?"
  fi

  # Reload Hyprland
  hyprctl reload || return "$?"
}

main "$@" || exit "$?"
