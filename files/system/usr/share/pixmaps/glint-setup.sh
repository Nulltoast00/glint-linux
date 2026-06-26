#!/bin/bash

# 1. greeeeeeeeeeeeeeeeeteing
kdialog --title "Welcome to Glint Linux" \
        --icon "/usr/share/pixmaps/logo.png" \
        --msgbox "Thank you for choosing Glint Linux!\n\nClick OK to install your core applications and other optimizations."

echo "Configuring Core Applications..."
flatpak remote-add --if-not-exists flathub https://flathub.org

flatpak install -y flathub org.mozilla.firefox \
                           org.libreoffice.LibreOffice \
                           com.valvesoftware.Steam \
                           net.davidotek.pupgui2 \
                           net.lutris.Lutris \
                           com.spotify.Client \
                           us.zoom.Zoom

echo "Applying user gaming optimizations..."
mkdir -p ~/.config/environment.d
echo "vm.swappiness=5" > ~/.config/environment.d/99-gaming.conf

# self destruct
kdialog --title "Glint Linux" --msgbox "Glint is ready. Enjoy!"
rm -- "$0"
