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

# Ff logo
fastfetch
EOF

echo "Overriding KDE About System Logo Graphic..."
mkdir -p /etc/xdg/kdedefaults
cat << 'EOF' > /etc/xdg/kdedefaults/kcm-about-distrorc
[General]
LogoPath=/usr/share/pixmaps/glint-logo.png
EOF

echo "Pre-configuring SKLauncher Auto-Setup for first login..."
mkdir -p /etc/skel/.config/autostart

cat << 'EOF' > /etc/skel/.config/autostart/glint-apps.desktop
[Desktop Entry]
Type=Application
Name=Glint App Setup
Exec=bash -c "mkdir -p ~/.var/app/games/sklauncher && curl -L -o ~/.var/app/games/sklauncher/sklauncher.jar https://github.com && flatpak remote-add --if-not-exists flathub https://flathub.org && flatpak install -y flathub org.mozilla.firefox org.libreoffice.LibreOffice com.valvesoftware.Steam net.davidotek.pupgui2 net.lutris.Lutris com.spotify.Client us.zoom.Zoom; rm -f ~/.config/autostart/glint-apps.desktop"
Icon=system-run
X-KDE-AutostartScript=true
EOF

echo "Glint master script layer finished!"
exit 0
