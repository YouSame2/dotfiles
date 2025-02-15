-- OS SPECIFIC OPTS:
-- =================
local os_name = vim.loop.os_uname().sysname
if os_name == "Windows_NT" then
  vim.o.shelltemp = false    -- prefer piping rather than temp files in shell commands (i.e. :%!sort) windows sometimes cant read the temp files
  vim.opt.shell = "bash"     -- use bashshell (gitbash)
  vim.opt.shellcmdflag = "-c" -- equal to bash.exe -c
  -- vim.opt.shellslash = true -- breaks telescope help_tags. originally used because im using gitbash in windows. but dont think i need it.
  vim.opt.shellxquote = ""   -- wrap shell cmd's in nothing
else
  -- vim.cmd("set shell=/bin/zsh") -- just incase needed
end

-- OPTIONS:
-- =================

-- editing
vim.cmd.colorscheme("tokyonight")
vim.opt.undofile = true
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
-- vim.opt.virtualedit = "block" -- idk bout this one but just incase

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

-- appearance
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true -- True color support
vim.opt.wrap = true

-- NOT RECOMMENDED just for reference in case slow nvim
-- vim.g.nofsync = true

-- CUSTOM STATUSLINE:
-- =================
local function statusline()
  local file_name = " %f"
  local modified = "%m"
  local align_right = "%="
  local fileencoding = " %{&fileencoding?&fileencoding:&encoding}"
  local fileformat = " [%{&fileformat}]"
  local filetype = " %y"
  local percentage = " %p%%"

  return string.format(
    "%s%s%s%s%s%s%s",
    file_name,
    modified,
    align_right,
    filetype,
    fileencoding,
    fileformat,
    percentage
  )
end
vim.opt.statusline = statusline()
