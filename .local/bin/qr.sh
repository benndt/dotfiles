#!/usr/bin/env bash

_open_qr() {
  hour=$(date +%-H)

  if [[ $hour -ge 5 && $hour -le 6 ]]; then
    hyprctl dispatch 'hl.dsp.exec_cmd("gwenview --spotlight ~/images/qr/catppuccin_alarm_clock.png")'
  fi
}

_open_qr
