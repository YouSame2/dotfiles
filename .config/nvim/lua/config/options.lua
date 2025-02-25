-- OS SPECIFIC OPTS:
-- =================
local os_name = vim.loop.os_uname().sysname
if os_name == "Windows_NT" then
	vim.o.shelltemp = false -- prefer piping rather than temp files in shell commands (i.e. :%!sort) windows sometimes cant read the temp files
	vim.opt.shell = "bash" -- use bashshell (gitbash)
	vim.opt.shellcmdflag = "-c" -- equal to bash.exe -c
	-- vim.opt.shellslash = true -- breaks telescope help_tags. originally used because im using gitbash in windows. but dont think i need it.
	vim.opt.shellxquote = "" -- wrap shell cmd's in nothing

-- NOT RECOMMENDED just for reference in case slow nvim
-- vim.g.nofsync = true
else
	-- vim.cmd("set shell=/bin/zsh") -- just incase needed
end

-- CUSTOM STATUSLINE:
-- =================
local function statusline()
	-- local file_name = " %f"
	local modified = "%m"
	local align_right = "%="
	local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
	local fileformat = " %{&fileformat}"
	local filetype = " %Y"
	local percentage = " %p%%"

	return string.format("%s%s%s%s%s%s", align_right, modified, filetype, fileencoding, fileformat, percentage)
end
vim.opt.statusline = statusline()

-- OPTIONS:
-- =================

-- editing
vim.cmd.colorscheme("default")
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.virtualedit = "block" -- idk bout this one but just incase

vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.ignorecase = true
vim.opt.infercase = true
vim.opt.smartcase = true

vim.opt.jumpoptions = "clean,stack"
vim.opt.shiftround = true -- Round indent

-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true -- True color support
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175" -- from help example

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
