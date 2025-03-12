#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Determine the config file based on the hostname
if [[ "$(hostname)" == "thinkpad" ]]; then
  polybar thinkpad
else
  polybar desktop
fi

