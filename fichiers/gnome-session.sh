#!/usr/bin/bash

set -euo pipefail

gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
gsettings set org.gnome.desktop.session 'idle-delay' 600
gsettings set org.gnome.desktop.notifications show-in-lock-screen 'false'
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

cat > ~/.config/autostart/ignore-lid-switch-tweak.desktop << EOF
[Desktop Entry]
Type=Application
Name=ignore-lid-switch-tweak
Exec=/usr/lib/gnome-tweak-tool-lid-inhibitor
EOF

