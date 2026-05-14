local colors = require("themes.mocha")

hl.config({
	general = {
		gaps_in = 6,
		gaps_out = 12,
		gaps_workspaces = 50,

		border_size = 2,
		col = {
			active_border = {
				colors = { "rgba(" .. colors.mauveAlpha .. "ee)", "rgba(" .. colors.skyAlpha .. "ee)" },
				angle = 45,
			},
			inactive_border = "rgba(" .. colors.surface2Alpha .. "aa)",
		},

		allow_tearing = true,
		resize_on_border = true,

		snap = {
			enabled = true,

			monitor_gap = 12,
			respect_gaps = true,
			window_gap = 6,
		},
	},
})
