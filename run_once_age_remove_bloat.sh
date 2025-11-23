#!/bin/bash

SOURCE_DIR=$HOME/.local/share/chezmoi

echo "Removing Omarchy bloat..."

[ -f "$SOURCE_DIR/bloat.list" ] && \
  xargs yay -Rns < "$SOURCE_DIR/bloat.list"
