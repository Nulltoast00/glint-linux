#!/bin/bash

echo "Branding the system as Glint Linux..."
sed -i 's/^NAME=.*/NAME="Glint Linux"/' /etc/os-release || true
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Glint Linux"/' /etc/os-release || true
sed -i 's/^VARIANT=.*/VARIANT="Standard Edition"/' /etc/os-release || true

echo "Applying Intel performance tweaks..."
mkdir -p /etc/modprobe.d /etc/sysctl.d
echo "options i915 enable_guc=3" > /etc/modprobe.d/i915.conf
echo "vm.swappiness=5" >> /etc/sysctl.d/99-gaming.conf
echo "fs.file-max=2097152" >> /etc/sysctl.d/99-gaming.conf

echo "Injecting Global Glint Terminal Shortcuts..."
mkdir -p /etc/profile.d
cat << 'EOF' > /etc/profile.d/glint.sh
# Glint Linux System Controls
alias glint-update="rpm-ostree upgrade"
alias glint-rollback="rpm-ostree rollback"
alias glint-clean="flatpak uninstall --unused -y && sudo rpm-ostree cleanup -m"
alias cls="clear"

# fastfetch boot logo
fastfetch
EOF

echo "Overriding KDE About System Logo Graphic..."
mkdir -p /usr/share/pixmaps /etc/xdg/kdedefaults
cat << 'EOF' > /etc/xdg/kdedefaults/kcm-about-distrorc
[General]
LogoPath=/usr/share/pixmaps/glint-logo.png
EOF

echo "Pre-configuring SKLauncher Auto-Setup Launcher icon..."
# Using /usr/share/applications ensuring the system drops the menu shortcut cleanly
mkdir -p /usr/share/applications
cat << 'EOF' > /usr/share/applications/sklauncher.desktop
[Desktop Entry]
Name=SKLauncher Setup
Comment=Click to install Cracked Minecraft Launcher
Exec=bash -c "mkdir -p ~/Games/SKLauncher && curl -L -o ~/Games/SKLauncher/sklauncher.jar https://github.com && flatpak remote-add --if-not-exists flathub https://flathub.org && flatpak install -y flathub org.mozilla.firefox org.libreoffice.LibreOffice com.valvesoftware.Steam net.davidotek.pupgui2 net.lutris.Lutris com.spotify.Client us.zoom.Zoom && zenity --info --text='Glint Linux Setup Complete! Apps and Minecraft are ready.' && sed -i 's/Name=.*/Name=SKLauncher/' ~/Desktop/sklauncher.desktop && sed -i 's/Exec=.*/Exec=gamemoderun java -jar ~\/Games\/SKLauncher\/sklauncher.jar/' ~/Desktop/sklauncher.desktop"
Icon=minecraft
Terminal=false
Type=Application
Categories=Game;
EOF

echo "Creating an automatic Desktop Shortcut link copy..."
mkdir -p /etc/skel/Desktop
cp /usr/share/applications/sklauncher.desktop /etc/skel/Desktop/sklauncher.desktop
chmod +x /etc/skel/Desktop/sklauncher.desktop || true

echo "Glint master script layer finished!"
