#!/bin/bash

function main() {
  local is_paused
  is_paused="$(dunstctl is-paused)" || return "$?"

  if [ "${is_paused}" = "true" ]; then
    dunstctl set-paused false || return "$?"
  else
    dunstctl set-paused true || return "$?"
  fi
}

main "$@" || exit "$?"
