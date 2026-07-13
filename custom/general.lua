hl.config({
	general = {
		-- Gaps and border
		gaps_in = 2,
		gaps_out = 3,
		gaps_workspaces = 40,

		border_size = 0
	},

	decoration = {
		-- 2 = circle, higher = squircle, 4 = very obvious squircle
		-- Fuck clearly visible squircles. 100% Apple brainrot.
		rounding_power = 2,
		rounding = 7,

		blur = {
			size = 10,
			passes = 3
		},
	}
})
