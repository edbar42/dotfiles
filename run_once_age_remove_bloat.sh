#!/bin/bash

SOURCE_DIR="$(chezmoi source-path)"

echo "Removing Omarchy bloat..."
[ -f "$SOURCE_DIR/bloat.txt" ] && \
  xargs -r yay -Rns --noconfirm
