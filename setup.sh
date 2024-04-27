#!/bin/bash

clear
echo "We need sudo priviledges for installing packages."
echo "Please provide your password."
sudo -v

echo "Checking if yay is installed on your system..."
command -v yay &> /dev/null || exit 1 "Yay doesn't seem to be installed."

echo "Updating repositories..."
yay -Syy

echo "Installing dependencies..."
cat ./packages | xargs yay -S --needed --noconfirm
git clone https://github.com/romkatv/powerlevel10k

echo "You will now set up p10k"
p10k configure

echo "Linking dotfiles..."
stow --dotfiles -v .

sleep 2
echo "We're logging you out of i3 to make sure everything is properly handled."

sleep 2
i3-msg exit
