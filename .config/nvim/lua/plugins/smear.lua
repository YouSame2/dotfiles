return {
	event = "VeryLazy",
	"sphamba/smear-cursor.nvim",
	opts = { -- Default  Range
		stiffness = 0.8, -- 0.6      [0, 1]
		trailing_stiffness = 0.4, -- 0.3      [0, 1]
		distance_stop_animating = 0.5, -- 0.1      > 0
		legacy_computing_symbols_support = true,
		hide_target_hack = true,
		smear_insert_mode = false,
	},
}
