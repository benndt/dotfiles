while ! pidof "hyprpaper" > /dev/null; do
  sleep 1
done

sleep 1

hour=$(date +%-H)

if [[ $hour -ge 20 || $hour -lt 6 ]]; then
  hyprctl hyprpaper wallpaper ',~/images/wallpaper/lakeside-evening-deer.png'
elif [[ $hour -ge 16 && $hour -lt 20 ]]; then
  hyprctl hyprpaper wallpaper ',~/images/wallpaper/lakeside-sunset-deer.png'
elif [[ $hour -ge 6 ]]; then
  hyprctl hyprpaper wallpaper ',~/images/wallpaper/lakeside-sunrise-deer.png'
fi
