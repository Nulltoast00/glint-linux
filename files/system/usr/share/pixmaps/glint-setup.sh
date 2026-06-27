#!/bin/bash

kdialog --title "Welcome to Glint Linux" \
        --icon "/usr/share/pixmaps/logo.png" \
        --msgbox "Thank you for choosing Glint Linux!\n\nClick OK to initialize your custom core applications and gaming optimizations."

echo "Configuring Core Applications..."

flatpak remote-delete flathub 2>/dev/null
flatpak remote-add --if-not-exists flathub https://flathub.org
flatpak update --refresh -y

flatpak install -y flathub org.mozilla.firefox \
                           org.libreoffice.LibreOffice \
                           com.valvesoftware.Steam \
                           net.lutris.Lutris \
                           com.spotify.Client \
                           us.zoom.Zoom \
                           org.bofh.Bottles \
                           net.davidotek.pupgui2 \
                           org.freedesktop.Platform.Icontheme.Adwaita \
                           org.freedesktop.Sdk.Extension.tool.jetbrains-mono \
                           com.discordapp.Discord

echo "Applying user gaming optimizations..."
mkdir -p ~/.config/environment.d
echo "vm.swappiness=5" > ~/.config/environment.d/99-gaming.conf
echo "fs.file-max=2097152" >> ~/.config/environment.d/99-gaming.conf

kdialog --title "Glint Linux" --msgbox "Glint Linux Setup Complete! Your apps, Wine management, and Proton tools are ready to roll."
rm -- "$0"
