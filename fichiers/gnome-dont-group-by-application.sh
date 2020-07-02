#!/bin/bash

# Copyright 2020 Sébastien Millet

set -euo pipefail

dconf write /org/gnome/desktop/wm/keybindings/switch-applications \
    "['<Super>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-applications-backward \
    "['<Shift><Super>Tab']"

dconf write /org/gnome/desktop/wm/keybindings/switch-windows \
    "['<Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward \
    "['<Shift><Alt>Tab']"
