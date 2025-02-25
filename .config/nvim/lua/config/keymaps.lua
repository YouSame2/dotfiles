vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down 1
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up 1

vim.keymap.set("n", "<C-u>", "<C-u>zz") -- center on half page up
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- center on half page down
vim.keymap.set("n", "}", "}zz") -- center on next paragraph
vim.keymap.set("n", "{", "{zz") -- center on previous paragraph
vim.keymap.set("n", "n", "nzzzv") -- center on search next
vim.keymap.set("n", "N", "Nzzzv") -- center on search prev
vim.keymap.set("n", "'", function() -- center on goto mark
	return "'" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { noremap = true, expr = true })
vim.keymap.set("n", "`", function() -- center on goto mark diff than "'"
	return "`" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { noremap = true, expr = true })

vim.keymap.set("x", "<leader>p", [["_dP]]) -- P over selection but keep paste register
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d') -- d over selection but keep paste register
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D') -- D over selection but keep paste register

-- NOTE: recommend using these copy/paste rather than terms, there better. :D
vim.keymap.set({ "v", "!", "t" }, "<C-S-c>", [["+y]]) -- y to system cb
vim.keymap.set("n", "<C-S-c><C-S-c>", [["+Y]]) -- yy to system cb
vim.keymap.set("n", "<C-S-c>", [["+y]]) -- Y to system cb
vim.keymap.set({ "n", "v" }, "<C-S-v>", [["+p]]) -- p from system cb
vim.keymap.set({ "!", "t" }, "<C-S-v>", [[<C-r>+]]) -- p from keep cb
vim.keymap.set({ "v" }, "<leader><C-S-v>", [["_d"+P]]) -- P from system cb over selection, keep paste register

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- TODO:

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- sub current word under cursor
--
-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- buffers
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
