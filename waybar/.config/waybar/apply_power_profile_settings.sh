#!/bin/bash

function main() {
  local profile
  profile="$(powerprofilesctl get)" || return "$?"

  # Update config file
  cp "${HOME}/.config/hypr/hyprland.conf.d/.05_power_${profile}.conf" ~/.config/hypr/hyprland.conf.d/05_power.conf || return "$?"

  # Reload Hyprland
  hyprctl reload || return "$?"
}

main "$@" || exit "$?"
