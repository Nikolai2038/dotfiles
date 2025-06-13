#!/bin/bash

function main() {
  # Show prompt
  # if GTK_THEME=Breeze:dark zenity --question --title='Clear Notifications' --text='Are you sure you want to clear all notifications?'; then

  # Clear notifications
  dunstctl history-clear || return "$?"

  # fi
}

main "$@" || exit "$?"
