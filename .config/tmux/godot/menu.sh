#!/usr/bin/env bash

show_menu() {
  tmux display-menu -T "#[align=centre fg=blue]godot" -x M -y W \
    "gdradon" r "send-keys 'gdradon cc .' c-m" \
    "gdformat" f "send-keys 'gdformat .' c-m" \
    "gdlint" l "send-keys 'gdlint .' c-m"
}

show_menu
