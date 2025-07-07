#!/bin/bash

function change_monitor() {
  local monitor="$1" && shift
  local params="$1" && shift

  # If specified monitor is connected
  if hyprctl monitors | grep -q "^Monitor ${monitor}"; then
    # Change it's settings
    hyprctl keyword monitor "${monitor}, ${params}" || return "$?"

    # Wait until Hyprland reconfigure the monitor.
    # If we do not wait, other monitors will wrongly set their positions.
    local iterations=0
    while ! hyprctl monitors | grep -q "^Monitor ${monitor}"; do
      sleep 0.5

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

  if hyprctl monitors | grep -q '^Monitor HDMI-A-1'; then
    # Change the monitors by script, because "hyprctl reload" does not correctly wait for them to turn on.
    if [ "${profile}" = "power-saver" ]; then
      change_monitor "HDMI-A-1" "1920x1080@60, 0x0, 1.0" || return "$?"
      change_monitor "eDP-2" "1920x1080@60, 1920x0, 1.0" || return "$?"
    elif [ "${profile}" = "balanced" ]; then
      change_monitor "HDMI-A-1" "1920x1080@60, 0x0, 1.0" || return "$?"
      change_monitor "eDP-2" "2560x1440@60, 1920x0, 1.6" || return "$?"
    elif [ "${profile}" = "performance" ]; then
      change_monitor "HDMI-A-1" "1920x1080@60, 0x0, 1.0" || return "$?"
      change_monitor "eDP-2" "2560x1440@165, 1920x0, 1.6" || return "$?"
    fi
  else
    # Change the monitors by script, because "hyprctl reload" does not correctly wait for them to turn on.
    if [ "${profile}" = "power-saver" ]; then
      change_monitor "DP-1" "1920x1080@60, 0x0, 1.0" || return "$?"
      change_monitor "DP-2" "1920x1080@60, 1920x0, 1.0" || return "$?"
      change_monitor "eDP-2" "1920x1080@60, 3840x0, 1.0" || return "$?"
    elif [ "${profile}" = "balanced" ]; then
      change_monitor "DP-1" "1920x1080@60, 0x0, 1.0" || return "$?"
      change_monitor "DP-2" "2560x1440@60, 1920x-360, 1.0" || return "$?"
      change_monitor "eDP-2" "2560x1440@60, 4480x0, 1.6" || return "$?"
    elif [ "${profile}" = "performance" ]; then
      change_monitor "DP-1" "1920x1080@144, 0x0, 1.0" || return "$?"
      change_monitor "DP-2" "2560x1440@175, 1920x-360, 1.0" || return "$?"
      change_monitor "eDP-2" "2560x1440@165, 4480x0, 1.6" || return "$?"
    fi
  fi

  # https://wiki.hypr.land/Configuring/Performance/
  if [ "${profile}" = "power-saver" ]; then
    # Disable fancy but battery hungry effects
    hyprctl dispatch exec "decoration.shadow.enabled=false" || return "$?"
    hyprctl dispatch exec "decoration.blur.enabled=false" || return "$?"

    # Disable animations
    hyprctl dispatch exec "animations.enabled=false" || return "$?"

    # Lower the amount of sent frames when nothing is happening on-screen
    hyprctl dispatch exec "misc.vfr=true" || return "$?"

    brightnessctl set 25% || return "$?"
  elif [ "${profile}" = "balanced" ]; then
    # Disable fancy but battery hungry effects
    hyprctl dispatch exec "decoration.shadow.enabled=false" || return "$?"
    hyprctl dispatch exec "decoration.blur.enabled=false" || return "$?"

    # Disable animations
    hyprctl dispatch exec "animations.enabled=false" || return "$?"

    # Lower the amount of sent frames when nothing is happening on-screen
    hyprctl dispatch exec "misc.vfr=true" || return "$?"

    brightnessctl set 50% || return "$?"
  elif [ "${profile}" = "performance" ]; then
    hyprctl dispatch exec "decoration.shadow.enabled=true" || return "$?"
    hyprctl dispatch exec "decoration.blur.enabled=true" || return "$?"
    hyprctl dispatch exec "animations.enabled=true" || return "$?"
    hyprctl dispatch exec "misc.vfr=false" || return "$?"

    brightnessctl set 100% || return "$?"
  fi
}

main "$@" || exit "$?"
