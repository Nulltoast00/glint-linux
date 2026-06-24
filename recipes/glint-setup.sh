#!/bin/bash
set -e

echo "Branding the system as Glint Linux..."
sed -i 's/^NAME=.*/NAME="Glint Linux"/' /etc/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="Glint Linux"/' /etc/os-release
sed -i 's/^VARIANT=.*/VARIANT="Standard Edition"/' /etc/os-release

echo "Applying Intel performance tweaks..."
echo "options i915 enable_guc=3" > /etc/modprobe.d/i915.conf
echo "vm.swappiness=5" >> /etc/sysctl.d/99-gaming.conf
echo "fs.file-max=2097152" >> /etc/sysctl.d/99-gaming.conf

echo "Injecting Global Glint Terminal Shortcuts..."
cat << 'EOF' > /etc/profile.d/glint.sh
# Glint Linux System Controls
alias glint-update="rpm-ostree upgrade"
alias glint-rollback="rpm-ostree rollback"
alias glint-clean="flatpak uninstall --unused -y && sudo rpm-ostree cleanup -m"
alias cls="clear"

# Fires up your custom Braille skull logo on boot!
fastfetch
EOF

echo "Overriding KDE About System Logo Graphic..."
mkdir -p /etc/xdg/kdedefaults
cat << 'EOF' > /etc/xdg/kdedefaults/kcm-about-distrorc
[General]
LogoPath=/usr/share/pixmaps/glint-logo.png
EOF

echo "Pre-installing SKLauncher for Cracked Minecraft..."
mkdir -p /usr/share/sklauncher
# Downloads the raw jar archive into the global system bin paths
curl -L -o /usr/share/sklauncher/sklauncher.jar "https://github.com"

cat << 'EOF' > /usr/bin/sklauncher
#!/bin/bash
gamemoderun java -jar /usr/share/sklauncher/sklauncher.jar
EOF
chmod +x /usr/bin/sklauncher

mkdir -p /usr/share/applications
cat << 'EOF' > /usr/share/applications/sklauncher.desktop
[Desktop Entry]
Name=SKLauncher
Comment=Cracked Minecraft Launcher
Exec=/usr/bin/sklauncher
Icon=minecraft
Terminal=false
Type=Application
Categories=Game;
EOF
