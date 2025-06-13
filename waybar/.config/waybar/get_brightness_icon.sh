#!/bin/bash

function main() {
  local brightness
  brightness="$(($(brightnessctl get) * 100 / $(brightnessctl max)))" || return "$?"

  if [ "${brightness}" -ge 80 ]; then
    echo -n "🌕"
  elif [ "${brightness}" -ge 60 ]; then
    echo -n "🌔"
  elif [ "${brightness}" -ge 40 ]; then
    echo -n "🌓"
  elif [ "${brightness}" -ge 20 ]; then
    echo -n "🌒"
  else
    echo -n "🌑"
  fi

  echo "${brightness}%"
}

main "$@" || exit "$?"
