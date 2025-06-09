#!/bin/bash

function main() {
  local profile
  profile="$(powerprofilesctl get)" || return "$?"

  if [ "${profile}" = "power-saver" ]; then
    echo -n "🌿"
  elif [ "${profile}" = "balanced" ]; then
    echo -n "⚖️"
  elif [ "${profile}" = "performance" ]; then
    echo -n "🚀"
  else
    echo -n "⚠️"
  fi

  # local battery_level
  # battery_level="$(cat /sys/class/power_supply/BAT1/capacity)" || return "$?"

  # local battery_status
  # battery_status="$(cat /sys/class/power_supply/BAT1/status)" || return "$?"

  # if [ "${battery_status}" = "Full" ] || [ "${battery_status}" = "Not charging" ]; then
  #   echo -n ""
  # elif [ "${battery_status}" = "Charging" ]; then
  #   echo -n ""
  # elif [ "${battery_status}" = "Discharging" ]; then
  #   if [ "${battery_level}" -gt 95 ]; then
  #     echo -n "  "
  #   elif [ "${battery_level}" -gt 75 ]; then
  #     echo -n "  "
  #   elif [ "${battery_level}" -gt 50 ]; then
  #     echo -n "  "
  #   elif [ "${battery_level}" -gt 25 ]; then
  #     echo -n "  "
  #   elif [ "${battery_level}" -gt 5 ]; then
  #     echo -n "  "
  #   fi
  # else
  #   echo -n "⚠️"
  # fi

  # echo " ${battery_level}%" || return "$?"
}

main "$@" || exit "$?"
