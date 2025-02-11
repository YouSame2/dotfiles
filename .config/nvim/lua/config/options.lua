vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("colorscheme tokyonight")
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.termguicolors = true -- True color support


-- NOT RECOMMENDED just for reference in case slow nvim
-- vim.g.nofsync = true

-- Determine the OS and set the shell accordingly.
local os_name = vim.loop.os_uname().sysname

-- if os_name == "Windows_NT" then
-- 	vim.cmd("set shell=powershell")
-- else
-- 	vim.cmd("set shell=/bin/zsh")
-- end

vim.opt.shell = "bash"
vim.opt.shellcmdflag = "-c"
vim.opt.shellxquote = ""
vim.opt.shellslash = true
-- prefer piping rather than temp files in shell commands (i.e. :%!sort)
-- windows sometimes cant read the temp files
vim.o.shelltemp = false
