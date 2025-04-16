return {
	"olimorris/codecompanion.nvim",
	enabled = true,
	lazy = false,
	dependencies = {
		"j-hui/fidget.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	-- TODO: change file selector to telescope
	config = function()
		require("codecompanion").setup({
			display = {
				chat = {
					show_settings = true,
				},
			},
			strategies = {
				chat = {
					adapter = "gemini",
				},
				inline = {
					adapter = "gemini",
				},
			},
		})
		vim.keymap.set(
			{ "n", "v" },
			"<leader>a<Tab>",
			"<cmd>CodeCompanionActions<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<leader>aa",
			"<cmd>CodeCompanionChat Toggle<cr>",
			{ noremap = true, silent = true }
		)
		vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

		-- Expand 'cc' into 'CodeCompanion' in the command line
		vim.cmd([[cab cc CodeCompanion]])
	end,
}
