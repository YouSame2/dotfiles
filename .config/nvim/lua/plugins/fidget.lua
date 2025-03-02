return {
	"j-hui/fidget.nvim",
	event = "VeryLazy",
	opts = {
		notification = {
			view = {
				stack_upwards = false, -- false = oldest on bottom
			},
			window = {
				winblend = 0, -- 0 = full transparent
				border = "rounded",
			},
		},
	},
}
