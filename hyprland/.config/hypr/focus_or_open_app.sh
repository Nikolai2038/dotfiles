#!/bin/bash

function main() {
  local class="${1}" && shift
  local default_workspace="${1}" && shift
  local is_force_new_window="${1:-0}" && shift

  # ========================================
  # Open new window on the current workspace
  # ========================================
  # If we explicitly requested to open a new window, we don't switch workspace - open on the current one.
  if [ "${is_force_new_window}" = "1" ]; then
    # Reload Hyprland rules to not include the "default_workspace" rule.
    hyprctl reload || return "$?"

    # Start the app (note that "uwsm" will hang until the app is closed)
    uwsm app -- "${class}.desktop" || return "$?"

    return 0
  fi
  # ========================================

  # ========================================
  # Focus already opened window
  # ========================================
  # NOTE: Previously, I used the following command, but it will work differently when you switch focus and workspaces a few times.
  #       So instead, we will use the "hyprctl clients" command to get the current windows.
  # if [ "$(hyprctl dispatch focuswindow "class:^(${class})\$")" = "No such window found" ]; then
  #   # ...
  # fi

  # Get all PIDs of the windows with the specified class
  local pids
  pids="$(hyprctl clients -j | jq -r --arg cls "${class}" '
    map(select(.class == $cls)) |
    .[].pid
  ')" || return "$?"

  # If window is open - focus on it
  if [ -n "${pids}" ]; then
    # We get PIDs elapsed time to focus the oldest window (because PIDs are random)
    local table_to_sort=""
    local pid
    for pid in ${pids}; do
      table_to_sort+="$(ps -p "${pid}" -o etime=) ${pid}
" || return "$?"
    done

    # Sort PIDs based on elapsed time of the process
    # NOTE: You can replace "tail" for "head" here to focus the newest window instead of the oldest one.
    local oldest_pid
    oldest_pid="$(echo "${table_to_sort}" | grep -vE '^$' | sort --key=1 --numeric-sort | awk '{print $2}' | tail -n 1)" || return "$?"

    # Get the address of the oldest window
    window_address="$(hyprctl clients -j | jq -r --arg pid "${oldest_pid}" '
      map(select(.pid == ($pid | tonumber))) |
      .[0].address
    ')" || return "$?"

    # Focus the window
    hyprctl dispatch focuswindow "address:${window_address}" || return "$?"

    return 0
  fi
  # ========================================

  # ========================================
  # Open new window on the default workspace
  # ========================================
  # NOTE: Switching workspace before opening the app is not enough, because the app will be opened on the workspace with current keyboard focus.
  #       And the keyboard focus will not change when workspace switches via this command.
  # hyprctl dispatch workspace "${default_workspace}" || return "$?"

  # Using workspace rule in the Hyprland config itself is bad, because it will force new windows to open on the default workspace too.
  # Instead, we create this rule dynamically, so it only applies until "hyprctl reload" is called.
  # - Wiki about "keyword": https://wiki.hypr.land/Configuring/Using-hyprctl/#keyword
  hyprctl keyword windowrulev2 "workspace ${default_workspace},class:^(${class})\$" || return "$?"

  # Start the app (note that "uwsm" will hang until the app is closed)
  uwsm app -- "${class}.desktop" || return "$?"
  # ========================================
}

main "$@" || exit "$?"
