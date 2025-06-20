#!/bin/bash

function main() {
  local is_paused
  is_paused="$(dunstctl is-paused)" || return "$?"

  if [ "${is_paused}" = "true" ]; then
    dunstctl set-paused false || return "$?"
  fi

  local number=""
  until [ "${number}" = "0" ]; do
    dunstctl history-pop || return "$?"
    number="$(dunstctl history | jq '.data[] | length')" || return "$?"
  done
}

main "$@" || exit "$?"
