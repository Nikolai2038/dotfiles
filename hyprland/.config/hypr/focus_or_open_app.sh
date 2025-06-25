#!/bin/bash

function main() {
  local class="${1}" && shift
  local default_workspace="${1}" && shift
  local is_new_window="${1:-0}" && shift

  if [ "${is_new_window}" = "0" ]; then
    if [ "$(hyprctl dispatch focuswindow "class:^(${class})\$")" = "No such window found" ]; then
      # Switching workspace before opening the app is not enough, because the app will be opened on the workspace with current keyboard focus.
      # And the keyboard focus will not change when workspace switches via this command.
      # hyprctl dispatch workspace "${default_workspace}" || return "$?"

      # Using workspace rule in the Hyprland config itself is bad, because it will force new windows to open on the default workspace too.
      # Instead, we create this rule dynamically, so it only applies until "hyprctl reload" is called.
      # - Wiki about "keyword": https://wiki.hypr.land/Configuring/Using-hyprctl/#keyword
      hyprctl keyword windowrulev2 "workspace ${default_workspace},class:^(${class})\$" || return "$?"

      uwsm app -- "${class}.desktop" || return "$?"
    fi
  elif [ "${is_new_window}" = "1" ]; then
    # Reload Hyprland rules to not include the "default_workspace" rule above.
    hyprctl reload || return "$?"

    uwsm app -- "${class}.desktop" || return "$?"
  fi
}

main "$@" || exit "$?"
