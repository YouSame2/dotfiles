return {
	event = "VeryLazy",
	"mfussenegger/nvim-lint",
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			-- NOTE: since ruff is defined as an lsp and i have auto lsp attach settings (see lspconfig) that handles linting. enabling here will produce duplicate lints
			-- python = { "ruff" },
			sh = { "shellcheck" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "gl", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
