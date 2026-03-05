#!/usr/bin/env bash

_open_qr() {
  if [[ $hour -ge 5 && $hour -le 7 || true ]]; then
    hyprctl dispatch -- exec gwenview --spotlight ~/images/qr/catppuccin_alarm_clock.png
  fi
}

_open_qr
