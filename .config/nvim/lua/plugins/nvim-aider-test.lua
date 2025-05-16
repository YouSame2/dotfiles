return {
	dir = "~/Repos/Personal/nvim-aider",
	enabled = false,
	cmd = "Aider",
	name = "Aider",
	dependencies = {
		"folke/snacks.nvim",
		--- The below dependencies are optional
		-- "catppuccin/nvim",
		-- "nvim-tree/nvim-tree.lua",
	},
	opts = {
		auto_reload = true,
		-- default colors have syntax highlighting for code
		theme = {
			user_input_color = "",
			tool_output_color = "",
			tool_error_color = "",
			tool_warning_color = "",
			assistant_output_color = "",
			completion_menu_color = "",
			completion_menu_bg_color = "",
			completion_menu_current_color = "",
			completion_menu_current_bg_color = "",
		},
		win = {
			width = 0.5,
		},
		picker = "telescope",
	},
}
