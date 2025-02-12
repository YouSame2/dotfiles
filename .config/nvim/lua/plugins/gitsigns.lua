return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",

	config = function()
		local gs = require("gitsigns")
		gs.setup({
			signs = {
				add = { text = "▎" }, -- these are diff. from lazyvim
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
			},
		})

		-- KEYMAPS
		local keymap = vim.keymap
		keymap.set("n", "]h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gs.nav_hunk("next")
			end
		end, { desc = "Next Hunk" })
		keymap.set("n", "[h", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gs.nav_hunk("prev")
			end
		end, { desc = "Prev Hunk" })
		keymap.set("n", "]H", function()
			gs.nav_hunk("last")
		end, { desc = "Last Hunk" })
		keymap.set("n", "[H", function()
			gs.nav_hunk("first")
		end, { desc = "First Hunk" })
		keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
		keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
		keymap.set("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
		keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
		keymap.set("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
		keymap.set("n", "<leader>ghp", gs.preview_hunk_inline, { desc = "Preview Hunk Inline" })
		keymap.set("n", "<leader>ghb", function()
			gs.blame_line({ full = true })
		end, { desc = "Blame Line" })
		keymap.set("n", "<leader>ghB", function()
			gs.blame()
		end, { desc = "Blame Buffer" })
		keymap.set("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
		keymap.set("n", "<leader>ghD", function()
			gs.diffthis("~")
		end, { desc = "Diff This ~" })
		keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "GitSigns Select Hunk" })
	end,
}

-- NOTE: normally docs put keymaps in on_attach{}. i dont see the point of setting
-- up keybinds everytime a buffer attaches. seems inefficient. so instead im just
-- setting them up once in config function for ALL files types. testing it i didnt
-- see any issues but if i run into any ill swap back to how the docs had it; which
-- im including here for ref
--
-- opts = {
--   signs = {
--     add = { text = "▎" },
--     change = { text = "▎" },
--     delete = { text = "" },
--     topdelete = { text = "" },
--     changedelete = { text = "▎" },
--     untracked = { text = "▎" },
--   },
--   signs_staged = {
--     add = { text = "▎" },
--     change = { text = "▎" },
--     delete = { text = "" },
--     topdelete = { text = "" },
--     changedelete = { text = "▎" },
--   },
--   on_attach = function(buffer)
--     local gs = package.loaded.gitsigns
--
--     local function map(mode, l, r, desc)
--       vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
--     end
--
--     -- stylua: ignore start
--     map("n", "]h", function()
--       if vim.wo.diff then
--         vim.cmd.normal({ "]c", bang = true })
--       else
--         gs.nav_hunk("next")
--       end
--     end, "Next Hunk")
--     map("n", "[h", function()
--       if vim.wo.diff then
--         vim.cmd.normal({ "[c", bang = true })
--       else
--         gs.nav_hunk("prev")
--       end
--     end, "Prev Hunk")
--     map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
--     map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
--     map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
--     map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
--     map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
--     map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
--     map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
--     map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
--     map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
--     map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
--     map("n", "<leader>ghd", gs.diffthis, "Diff This")
--     map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
--     map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
--   end,
-- }
