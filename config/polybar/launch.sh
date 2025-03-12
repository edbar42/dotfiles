#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar

# Get the hostname
HOSTNAME=$(hostname)

# Determine the config file based on the hostname
if [[ "$HOSTNAME" == "thinkpad" ]]; then
  CONFIG_FILE="~/dotfiles/config/polybar/thinkpad.ini"
else
  CONFIG_FILE="~/dotfiles/config/polybar/config.ini"
fi

# Launch polybar with the determined config file
polybar -c "$CONFIG_FILE"

