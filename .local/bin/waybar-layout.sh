#!/usr/bin/env bash

_get_layout() {
  hyprctl getoption general:layout | grep -oP '(?<=str: )\S+'
}

_get_waybar_layout_json() {
  local layout

  layout=$(_get_layout)

  printf '{"alt":"%s", "text":"%s"}\n' "$layout" "$layout"
}

_get_waybar_layout_json
