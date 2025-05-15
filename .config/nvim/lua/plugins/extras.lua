-- =================================
--          UTIL COMMANDS
--    for stuff not used often
-- =================================

return {
	{
		-- helpgrep with telescope
		"catgoose/telescope-helpgrep.nvim",
		lazy = true,
		cond = not vim.g.vscode,
		keys = {
			{
				"<leader>sh",
				function()
					require("telescope").extensions.helpgrep.helpgrep() -- Run the extension
				end,
				desc = "[s]earch [h]elp by grep",
			},
		},
		config = function()
			require("telescope").load_extension("helpgrep")
		end,
	},
	{
		-- my custom telescope git diff extension
		"YouSame2/telescope-git-diff",
		lazy = true,
		cond = not vim.g.vscode,
    cmd = "Telescope git_diff",
		keys = {
			{
				"<leader>fgs",
				function()
					require("telescope").extensions.git_diff.git_diff()
				end,
				desc = "todo",
			},
		},
		config = function()
			require("telescope").load_extension("git_diff")
		end,
	},
	{
		-- search common commands with telescope
		"doctorfree/cheatsheet.nvim",
		cond = not vim.g.vscode,
		cmd = "Cheatsheet",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
		config = function()
			local ctactions = require("cheatsheet.telescope.actions")
			require("cheatsheet").setup({
				bundled_cheetsheets = {
					enabled = { "default", "lua", "markdown", "regex", "netrw", "unicode" },
					disabled = { "nerd-fonts" },
				},
				bundled_plugin_cheatsheets = {
					enabled = {
						-- "auto-session",
						-- "goto-preview",
						-- "octo.nvim",
						"telescope.nvim",
						"vim-easy-align",
						-- "vim-sandwich",
					},
					-- disabled = { "gitsigns" },
				},
				include_only_installed_plugins = true,
				telescope_mappings = {
					["<CR>"] = ctactions.select_or_fill_commandline,
					["<A-CR>"] = ctactions.select_or_execute,
					["<C-Y>"] = ctactions.copy_cheat_value,
					["<C-E>"] = ctactions.edit_user_cheatsheet,
				},
			})
		end,
	},
}
