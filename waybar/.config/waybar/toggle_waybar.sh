#!/bin/bash

function main() {
  echo "Applying 01_general..." >&2

  cat "${HOME}/.config/waybar/01_general.css" > "${HOME}/.config/waybar/style.css" || return "$?"

  # shellcheck disable=SC2320
  echo -en "\n\n" >> "${HOME}/.config/waybar/style.css" || return "$?"

  echo "Applying 01_general: success!" >&2

  local state_file="${HOME}/.config/waybar/.waybar_is_hidden.lock"

  if [ -f "${state_file}" ]; then
    echo "Applying 02_shown..." >&2
    rm "${state_file}" || return "$?"
    cat "${HOME}/.config/waybar/02_shown.css" >> "${HOME}/.config/waybar/style.css" || return "$?"
    echo "Applying 02_shown: success!" >&2
  else
    echo "Applying 02_hidden..." >&2
    touch "${state_file}" || return "$?"
    cat "${HOME}/.config/waybar/02_hidden.css" >> "${HOME}/.config/waybar/style.css" || return "$?"
    echo "Applying 02_hidden: success!" >&2
  fi

  # If waybar is not started yet
  if ! pgrep --exact --full waybar > /dev/null; then
    echo "Starting waybar..." >&2

    # Start waybar
    waybar &

    echo "Starting waybar: success!" >&2
  else
    echo "Reloading waybar..." >&2

    # Reload waybar
    pkill -SIGUSR2 waybar

    echo "Reloading waybar: success!" >&2
  fi
}

main "$@" || exit "$?"
