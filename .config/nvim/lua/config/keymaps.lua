vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "move selected line up" })
vim.keymap.set("n", "J", "mzJ`z", { desc = "move line up keep cursor position" })
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

vim.keymap.set({ "n", "s" }, "<esc>", function()
  vim.cmd("noh")
  return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- centering keymaps, i use a plugin called Go-Up (BEST PLUGIN EVER!) which remaps 'zz'
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "move selected line down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up & center", remap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down & center", remap = true })
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>zz", { desc = "next diagnostic & center", remap = true })
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>zz", { desc = "prev diagnostic & center", remap = true })
vim.keymap.set("n", "}", "}zz", { desc = "next paragraph & center", remap = true })
vim.keymap.set("n", "{", "{zz", { desc = "previous paragraph & center", remap = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "search next & center", remap = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "search prev & center", remap = true })
vim.keymap.set("n", "'", function()
  return "'" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { remap = true, expr = true, desc = "goto mark & center" })
vim.keymap.set("n", "`", function()
  return "`" .. vim.fn.nr2char(vim.fn.getchar()) .. "zz"
end, { remap = true, expr = true, desc = "goto mark & center" })

-- better copy, paste, yank. recommend using these copy/paste rather than terminals, there better. :D
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "P over selection keep p reg" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "d over selection keep p reg" })
vim.keymap.set({ "n", "v" }, "<leader>D", '"_D', { desc = "D over selection keep p reg" })
vim.keymap.set({ "v", "!", "t" }, "<C-S-c>", [["+y]], { desc = "y to system cb" })
vim.keymap.set("n", "<C-S-c><C-S-c>", [["+Y]], { desc = "yy to system cb" })
vim.keymap.set("n", "<C-S-c>", [["+y]], { desc = "Y to system cb" })
vim.keymap.set({ "n", "v" }, "<C-S-v>", [["+p]], { desc = "p from system cb" })
vim.keymap.set({ "!", "t" }, "<C-S-v>", [[<C-r>+]], { desc = "p from keep cb" })
vim.keymap.set({ "v" }, "<leader><C-S-v>", [["_d"+P]], { desc = "P from system cb over selection, keep p reg" })

vim.keymap.set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- TODO: move these to trouble when i add it
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous Quickfix", remap = true })
vim.keymap.set("n", "[Q", "<cmd>cfir<CR>zz", { desc = "Previous Quickfix", remap = true })
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next Quickfix", remap = true })
vim.keymap.set("n", "]Q", "<cmd>cla<CR>zz", { desc = "Next Quickfix", remap = true })

-- line wrap keymaps
-- =================
vim.keymap.set(
  "n",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, desc = "cursor N lines downward (include 'wrap')" }
)
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "cursor N lines up (include 'wrap')" })
vim.keymap.set("n", "0", "g0", { desc = "first char of the line (include 'wrap')" })
vim.keymap.set("n", "^", "g^", { desc = "first non-blank character of the line (include 'wrap')" })
vim.keymap.set("n", "$", "g$", { desc = "end of the line (include 'wrap')" })
---------------
-- NOTE: below changes behavior of Y,D,C to respect line wrap. comment out to have normal behavior. keep in mind you can still achive the same normal behavior just by double tapping. i.e. 'yy' or 'dd'
vim.keymap.set(
  "n",
  "D",
  "v:count == 0 ? 'dg$' : 'D'",
  { expr = true, desc = "[D]elete to end of line (include 'wrap')" }
)
vim.keymap.set(
  "n",
  "C",
  "v:count == 0 ? 'cg$' : 'C'",
  { expr = true, desc = "[C]hange to end of line (include 'wrap')" }
)
vim.keymap.set(
  "n",
  "Y",
  "v:count == 0 ? 'yg$' : 'y$'",
  { expr = true, desc = "[Y]ank to end of line (include 'wrap')" }
)
---------------
vim.keymap.set(
  "v",
  "j",
  "v:count == 0 ? 'gj' : 'j'",
  { expr = true, desc = "cursor N lines downward (include 'wrap')" }
)
vim.keymap.set("v", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, desc = "cursor N lines up (include 'wrap')" })
vim.keymap.set("v", "0", "g0", { desc = "first char of the line (include 'wrap')" })
vim.keymap.set("v", "^", "g^", { desc = "first non-blank character of the line (include 'wrap')" })
vim.keymap.set("v", "$", "g$", { desc = "end of the line (include 'wrap')" })

-- TODO:

-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]) -- sub current word under cursor
--
-- buffers
-- map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
-- map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
-- map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
