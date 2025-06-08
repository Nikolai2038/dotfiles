#!/bin/bash

function main() {
  if GTK_THEME=Adwaita:dark zenity --question --title='Clear Notifications' --text='Are you sure you want to clear all notifications?'; then
    # Clear notifications
    dunstctl history-clear || return "$?"
  fi
}

main "$@" || exit "$?"
