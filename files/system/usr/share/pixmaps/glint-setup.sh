#!/bin/bash

kdialog --title "Welcome to Glint Linux" \
        --icon "/usr/share/pixmaps/logo.png" \
        --msgbox "Thank you for choosing Glint Linux!\n\nClick OK to initialize your custom core applications and gaming optimizations."

echo "Configuring Core Applications..."
flatpak remote-add --if-not-exists flathub https://flathub.org

flatpak install -y flathub org.mozilla.firefox \
                           org.libreoffice.LibreOffice \
                           com.valvesoftware.Steam \
                           net.davidotek.pupgui2 \
                           net.lutris.Lutris \
                           com.spotify.Client \
                           us.zoom.Zoom \
                           org.bofh.Bottles \
                           net.davidotek.pupgui2

echo "Applying user gaming optimizations..."
mkdir -p ~/.config/environment.d
echo "vm.swappiness=5" > ~/.config/environment.d/99-gaming.conf

kdialog --title "Glint Linux" --msgbox "Glint Linux Setup Complete! Your apps, Wine management, and Proton tools are ready to roll."
rm -- "$0"
