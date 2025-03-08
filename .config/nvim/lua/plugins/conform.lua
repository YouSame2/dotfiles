-- credit: github.com/josean-dev
return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	event = "VeryLazy",
	config = function()
		local conform = require("conform")

		-- HACK: fixes space in windows username
		local function get_formatters()
			local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
			local formatters = {}
			local mason_dir = "C:\\Users\\PATRIC~1\\AppData\\Local\\nvim-data\\mason\\bin\\"

			if is_windows then
				formatters.prettier = {
					command = mason_dir .. "prettier.cmd",
				}
				formatters.stylua = {
					command = mason_dir .. "stylua.cmd",
				}
				formatters.isort = {
					command = mason_dir .. "isort.cmd",
				}
				formatters.black = {
					command = mason_dir .. "black.cmd",
				}
			end

			return formatters
		end

		conform.setup({
			-- default_format_opts = function ()
			--   -- function to set the default command passing the mason dir and whatever formater is being used
			-- end,
			formatters_by_ft = {
				-- javascript = { "prettier" },
				-- typescript = { "prettier" },
				-- javascriptreact = { "prettier" },
				-- typescriptreact = { "prettier" },
				-- svelte = { "prettier" },
				-- css = { "prettier" },
				-- html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				-- graphql = { "prettier" },
				-- liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},
			formatters = get_formatters(),
			format_on_save = {
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
			conform.format({
				lsp_fallback = false,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "format documant (conform)" })
	end,
}
