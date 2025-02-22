vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- move selected line down 1
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- move selected line up 1
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half page down center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half page up center
vim.keymap.set("n", "n", "nzzzv") -- center on search next
vim.keymap.set("n", "N", "Nzzzv") -- center on search prev
vim.keymap.set("x", "<leader>p", [["_dP]]) -- paste over visual selection but keep paste register
