## Glint Linux 

Glint Linux is a custom made operating system built specifically for Intel and AMD devices. It is an atomic, immutable "remix" powered by Fedora Kinoite Rawhide and the awesome KDE Plasma desktop enviroment. 

<p align="center">
  <img src="files/system/usr/share/pixmaps/glint-logo-full.png" alt="Glint Linux Logo" width="800">
</p>

IMPORTANT: Glint does NOT work with Nvidia graphics cards. Support will maybe come later down the line but for now, do not install this onto your system if you use Nvidia.

## Preinstalled Apps

1. Steam
2. Lutris
3. Zoom
4. Firefox
5. Spotify

Glint also has Proton and Wine baked into it, so you can run all your favourite Windows apps!

## Commands

Glint also features some custom terminal commands so you can manage your system easier. 

- 'glint-update' - Updates your system.
- 'glint-rollback' - If an update breaks something, you can use this to go back to your previous working system state.
-  'glint-clean'  - Cleans up old files and cache to give you more storage space.

## Installation Guide

1. Download the latest 'glint-iso' from the **Releases** tab of this repository
2. Flash your USB drive **(Minimum 8GB)**. Its reccomended to use **Ventoy** for this.
3. (if you used Ventoy) Drag and drop the 'glint-linux.iso' file into your Ventoy drive.
4. Reboot your machine and spam your boot key (could be F9,F10,F12 whatever depending on your hardware)
5. *MUST* connect to an internet connection.
6. Click "Enable Glint" on your desktop to install all optimizations/features and apps. Ensure your drive is formatted to the **Btrfs** file system.

*Note:* The core utilities, apps and all that aren't actually on the base installation. So that means if you want your audio and other optimizations, you have to click the "Enable Glint" icon on the desktop.

*Note for External Game Drives:* Install **Flatseal** from the software store, select Steam/Lutris, scroll to **Filesystems**, and grant permission to `/run/media` to read games off secondary storage pools without re-downloading them.
