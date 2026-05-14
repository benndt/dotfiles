local colors = require("themes.mocha")

hl.config({
	decoration = {
		rounding = 16,
		rounding_power = 2.4,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,

			color = "rgba(" .. colors.mantleAlpha .. "ee)",
			range = 6,
			render_power = 4,
		},

		blur = {
			enabled = true,

			passes = 1,
			size = 3,
		},
	},
})
