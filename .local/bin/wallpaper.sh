_get_suffix() {
  randomNumber=$(shuf -i 1-100 -n 1)

  if [[ $randomNumber -lt 50 ]]; then
    echo '-deer'
  fi
}

_get_daytime_wallpaper() {
  suffix=$(_get_suffix)
  hour=$(date +%-H)

  if [[ $hour -ge 23 || $hour -lt 7 ]]; then
    echo "midnight"
  elif [[ $hour -ge 20 && $hour -lt 23 ]]; then
    echo "evening${suffix}"
  elif [[ $hour -ge 16 && $hour -lt 20 ]]; then
    echo "sunset${suffix}"
  elif [[ $hour -ge 7 ]]; then
    echo "sunrise${suffix}"
  fi
}

_wait_for_hyprpaper() {
  while ! pidof "hyprpaper" > /dev/null; do
    sleep 1
  done

  sleep 1
}

_change_wallpaper() {
  _wait_for_hyprpaper

  daytime_wallpaper=$(_get_daytime_wallpaper)
  
  hyprctl hyprpaper wallpaper ",~/images/wallpaper/lakeside-${daytime_wallpaper}.png"
}

_change_wallpaper
