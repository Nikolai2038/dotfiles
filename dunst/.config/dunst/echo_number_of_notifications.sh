#!/bin/bash

function main() {
  local number
  number="$(dunstctl history | jq '.data[] | length')" || return "$?"

  # If number is 0 - we do not print it
  if [ "${number}" = "0" ]; then
    return 0
  fi

  echo -n "${number}"
}

main "$@" || exit "$?"
