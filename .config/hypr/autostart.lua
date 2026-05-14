hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'Catppuccin Mocha Lavender'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

	hl.exec_cmd("waybar")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("dunst")
	hl.exec_cmd("hypridle")

	hl.exec_cmd("~/.local/bin/wallpaper.sh")
	hl.exec_cmd("~/.local/bin/qr.sh")
end)
