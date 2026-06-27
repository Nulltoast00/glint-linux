#!/bin/bash

CHOICES=$(kdialog --title "Glint Software Setup" \
                  --icon "/usr/share/pixmaps/logo.png" \
                  --checklist "Welcome to Glint. Select which apps you want installed to your system." \
                  "STEAM" "Steam & Proton Up (Gaming Hub)" on \
                  "DISCORD" "Discord Chat Client" on \
                  "BROWSER" "Firefox Web Browser" on \
                  "OFFICE" "LibreOffice Suite" off \
                  2>/dev/null)

if [ $? -ne 0 ] || [ -z "$CHOICES" ]; then
    kdialog --title "Glint Linux" --msgbox "Setup cancelled. If you want, you can run this setup again from your desktop shortcut."
    exit 1
fi

flatpak remote-delete flathub 2>/dev/null
flatpak remote-add --if-not-exists flathub https://flathub.org
flatpak update --refresh -y

PROGRESS=$(kdialog --title "Glint Software Setup" --progressbar "Working on it..." 4 2>/dev/null)

kdialog --progressbar "$PROGRESS" 1 "Still working on it..."
flatpak install -y flathub org.freedesktop.Platform.Icontheme.Adwaita org.freedesktop.Sdk.Extension.tool.jetbrains-mono >/dev/null 2>&1

if [[ "$CHOICES" == *"BROWSER"* ]]; then
    kdialog --progressbar "$PROGRESS" 2 "Installing Firefox Web Browser..."
    flatpak install -y flathub org.mozilla.firefox >/dev/null 2>&1
fi

if [[ "$CHOICES" == *"STEAM"* ]]; then
    kdialog --progressbar "$PROGRESS" 3 "Installing Steam & Wine managers..."
    flatpak install -y flathub com.valvesoftware.Steam net.lutris.Lutris org.bofh.Bottles net.davidotek.pupgui2 >/dev/null 2>&1
fi

if [[ "$CHOICES" == *"DISCORD"* ]]; then
    kdialog --progressbar "$PROGRESS" 4 "Installing Discord..."
    flatpak install -y flathub com.discordapp.Discord >/dev/null 2>&1
fi

if [[ "$CHOICES" == *"OFFICE"* ]]; then
    flatpak install -y flathub org.libreoffice.LibreOffice >/dev/null 2>&1
fi

kdialog --progressbar "$PROGRESS" close 2>/dev/null

kdialog --title "Glint Linux" \
        --icon "/usr/share/pixmaps/logo.png" \
        --msgbox "Glint is ready!\n\nYour chosen software has been installed. Thank You!"

rm -- "$0"
