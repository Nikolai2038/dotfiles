#!/bin/bash

function main() {
  local number=""
  until [ "${number}" = "0" ]; do
    dunstctl history-pop || return "$?"
    number="$(dunstctl history | jq '.data[] | length')" || return "$?"
  done
}

main "$@" || exit "$?"
