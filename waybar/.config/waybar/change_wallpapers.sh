#!/bin/bash

function main() {
  echo "Waiting for \"hyprpaper\"..." >&2
  local waits=0
  # Check connection to the socket
  while ! hyprctl hyprpaper listactive; do
    sleep 0.1 || return "$?"
    ((waits++))

    # If we waited more than 10 seconds - return error
    if ((waits > 100)); then
      echo "Waiting for \"hyprpaper\": failed!" >&2
      return 1
    fi
  done
  echo "Waiting for \"hyprpaper\": success!" >&2

  declare -a monitors
  # My monitors
  monitors=(DP-1 DP-2 eDP-2) || return "$?"

  local monitors_count
  monitors_count="${#monitors[@]}" || return "$?"

  local wallpapers_as_string
  wallpapers_as_string="$(find "${HOME}/Pictures/Wallpapers/" -type f | shuf -n "${monitors_count}")" || return "$?"

  # Convert to array
  declare -a wallpapers
  local IFS_SAVED="${IFS}"
  IFS=$'\n'
  # shellcheck disable=SC2206
  wallpapers=(${wallpapers_as_string}) || return "$?"
  IFS="${IFS_SAVED}"

  local monitor_id
  for ((monitor_id = 0; monitor_id < monitors_count; monitor_id++)); do
    local monitor="${monitors[${monitor_id}]}"
    local wallpaper="${wallpapers[${monitor_id}]}"

    echo "Applying \"${wallpaper}\" for \"${monitor}\"..." >&2

    hyprctl hyprpaper preload "${wallpaper}" >&2 || return "$?"
    hyprctl hyprpaper wallpaper "${monitor},${wallpaper}" >&2 || return "$?"

    echo "Applying \"${wallpaper}\" for \"${monitor}\": success!" >&2
  done

  # Unload old images
  sleep 1
  hyprctl hyprpaper unload unused >&2 || return "$?"
}

main "$@" || exit "$?"
