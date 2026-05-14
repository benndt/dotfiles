hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = {
		class = "hyprland-run",
	},

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "flameshot-multi-display-fix",
	match = {
		class = "flameshot",
	},

	animation = "fade",
	rounding = 0,
	border_size = 0,
	fullscreen_state = "0 0",
	float = true,
	pin = true,
	monitor = "DP-1",
	move = "0 0",
	size = "(monitor_w*2) (monitor_h)",
})

hl.window_rule({
	name = "alarm-clock-qr",
	match = {
		title = ".*catppuccin_alarm_clock.*",
	},

	float = true,
	pin = true,
	size = "480 480",
	move = "(monitor_w*.74) (monitor_h*.62)",
})

hl.window_rule({
	name = "kde",
	match = {
		class = "^(org.freedesktop.impl.portal.desktop.kde)$",
	},

	float = true,
	center = true,
	size = "(monitor_w*.45) (monitor_h*.45)",
})

hl.window_rule({
	name = "pavucontrol",
	match = {
		class = "^(org.pulseaudio.pavucontrol)$",
	},

	float = true,
	center = true,
	size = "(monitor_w*.45) (monitor_h*.45)",
})

hl.window_rule({
	name = "kcalc",
	match = {
		class = "^(org.kde.kcalc)$",
	},

	float = true,
	center = true,
})

hl.window_rule({
	name = "nm-connection-editor",
	match = {
		class = "^(nm-connection-editor)$",
	},

	float = true,
	center = true,
	size = "(monitor_w*.45) (monitor_h*.45)",
})

hl.window_rule({
	name = "firefox-picture-in-picture",
	match = {
		class = "^(Picture-in-Picture)$",
	},

	float = true,
	center = true,
})

hl.window_rule({
	name = "exe-files",
	match = {
		title = ".*\\.exe",
	},
	immediate = true,
})

hl.window_rule({
	name = "minecraft",
	match = {
		title = ".*minecraft.*",
	},
	immediate = true,
})

hl.window_rule({
	name = "steam-games",
	match = {
		title = ".*(steam_app).*",
	},
	immediate = true,
})

hl.window_rule({
	name = "godot-debug",
	match = {
		class = "^(metroidvania)$",
	},

	float = true,
	fullscreen_state = "0 0",
	size = "(monitor_w/1.33) (monitor_h/1.33)",
})
