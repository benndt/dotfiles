#!/usr/bin/env bash

show_menu() {
  tmux display-menu -T "#[align=centre fg=blue]godot" -x M -y W \
    "clang-format" c "send-keys 'just clang-format' c-m" \
    "gdformat" f "send-keys 'just gdformat' c-m" \
    "gdlint" l "send-keys 'just gdlint' c-m" \
    "gdunit" u "send-keys 'just gdunit' c-m" \
    "lizard" z "send-keys 'just lizard' c-m" \
    "rumdl" r "send-keys 'just rumdl' c-m" \
    "typos" t "send-keys 'just typos' c-m" \
    "yamllint" y "send-keys 'just yamllint' c-m" \
    "" \
    "aseprite" a "send-keys 'aseprite' c-m" \
    "godot" g "send-keys 'godot' c-m" \
    "nvim" n "send-keys 'nvim' c-m"
}

show_menu
