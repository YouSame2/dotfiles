-- OS SPECIFIC OPTS:
-- =================
local os_name = vim.loop.os_uname().sysname
if os_name == "Windows_NT" then
	vim.o.shelltemp = false -- prefer piping rather than temp files in shell commands (i.e. :%!sort) windows sometimes cant read the temp files, in that case use shellpipe opt below
	vim.opt.shell = "bash" -- use bashshell (gitbash)
	vim.opt.shellcmdflag = "-c" -- equal to bash.exe -c
	vim.opt.shellxquote = "" -- wrap shell cmd's in nothing
	-- vim.opt.shellslash = true -- breaks telescope help_tags. originally used because im using gitbash in windows. but dont think i need it.
	vim.opt.shellpipe = '2>&1| tee "%s"' -- fixes cant write to temp files when spaces are in windows username. noticiable when using !grep

	-- NOT RECOMMENDED just for reference in case slow nvim
	-- vim.g.nofsync = true
end

-- OPTIONS:
-- =================

-- editing
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.mouse = "a"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.virtualedit = "block" -- idk bout this one but just incase

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true -- Round indent
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.jumpoptions = "clean,stack"

-- these 2 dont work cuz ft sets it on bufenter so i setup autocmd
-- vim.cmd("set formatoptions-=o") -- -o = 'o'/'O' dont add comment
-- vim.cmd("set formatoptions-=l") --  -l break existing long lines

-- appearance
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true -- True color support
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.guicursor =
	"n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- from help example

vim.api.nvim_set_hl(0, "WinSeparator", { link = "Conceal" }) -- change color of pane separators
vim.opt.laststatus = 3 -- only 1 global statusline. dont forget fillchars
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
	eob = " ",
}

-- CUSTOM STATUSLINE:
-- =================
-- local function statusline()
--   -- local file_name = " %f"
--   local set_color_2 = "%#TabLine#"
--   local modified = "%m"
--   local align_right = "%="
--   local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
--   local fileformat = " %{&fileformat}"
--   local filetype = " %Y"
--   local percentage = " %p%%"

--   return string.format(
--     "%s%s%s%s%s%s%s",
--     set_color_2,
--     align_right,
--     modified,
--     filetype,
--     fileencoding,
--     fileformat,
--     percentage
--   )
-- end

vim.cmd.colorscheme("Retrobox") -- loved default but after some time relized having good theme really helps quickly understanding code flow...
vim.api.nvim_set_hl(0, "LineNr", { link = "Identifier" })
vim.api.nvim_set_hl(0, "LineNrAbove", { link = "Comment" })
vim.api.nvim_set_hl(0, "LineNrBelow", { link = "Comment" })
-- old ones used for default colorscheme
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "NvimLightBlue" })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "NvimLightGray3" })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "NvimLightGray3" })
-- vim.opt.statusline = statusline() -- old version
require("utils/statusline")

-- transparency settings
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
vim.diagnostic.config({ float = { border = "rounded" } })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})
