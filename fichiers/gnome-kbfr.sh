#!/usr/bin/bash

set -euo pipefail

gsettings set org.gnome.desktop.input-sources xkb-options "['lv3:ralt_switch']"
gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'fr+oss')]"

