return {
	"joshuavial/aider.nvim",
	cmd = { "AiderOpen", "AiderAddModifiedFiles" },
	keys = {
		{
			"<leader>aa",
			"<cmd>AiderOpen<CR>",
			desc = "Toggle [a]ider [a]i",
		},
		{
			"<leader>af",
			"<cmd>AiderAddModifiedFiles<CR>",
			desc = "[a]ider add [f]iles",
		},
	},
	opts = {
		default_bindings = false, -- use default <leader>A keybindings
		auto_manage_context = true, -- automatically manage buffer context
		debug = false, -- enable debug logging
	},

	-- config = function()
	-- 	local aider = require("aider")

	-- 	aider.setup({
	-- 		auto_manage_context = true, -- automatically manage buffer context
	-- 		debug = false, -- enable debug logging
	-- 	})
	-- end,
}
