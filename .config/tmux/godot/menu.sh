#!/usr/bin/env bash

show_menu() {
  tmux display-menu -T "#[align=centre fg=blue]godot" -x M -y W \
    "gdradon" r "send-keys 'gdradon cc .' c-m" \
    "gdformat" f "send-keys 'gdformat .' c-m" \
    "gdlint" l "send-keys 'gdlint .' c-m" \
    "" \
    "godot" g "send-keys 'open \"\" \"C:\Godot_v4.3\Godot_v4.3-stable_win64.exe\" --editor' c-m" \
    "aseprite" a "send-keys 'open \"\" \"C:\Program Files\Aseprite\Aseprite.exe\"' c-m" \
    "nvim" n "send-keys 'nvim' c-m"
}

show_menu
