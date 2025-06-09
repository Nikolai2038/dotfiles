#!/bin/bash

function main() {
  local is_paused
  is_paused="$(dunstctl is-paused)" || return "$?"

  if [ "${is_paused}" = "true" ]; then
    echo -n " 🔕"
  else
    echo -n " 🔔"
  fi

  local number
  number="$(dunstctl history | jq '.data[] | length')" || return "$?"

  # If number is 0 - we do not print it
  if [ "${number}" != "0" ]; then
    echo -n "${number}"
  fi

  echo -n " "
}

main "$@" || exit "$?"
