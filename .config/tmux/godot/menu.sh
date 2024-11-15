#!/usr/bin/env bash

show_menu() {
  tmux display-menu -T "#[align=centre fg=blue]godot" -x M -y W \
    "gdradon" r "send-keys 'gdradon cc .' c-m" \
    "gdformat" f "send-keys 'gdformat .' c-m" \
    "gdlint" l "send-keys 'gdlint .' c-m" \
    "" \
    "godot" g "send-keys 'godot' c-m" \
    "aseprite" a "send-keys 'aseprite' c-m" \
    "nvim" n "send-keys 'nvim' c-m"
}

show_menu
