vim.opt.fileencoding = "utf-8" -- editorconfig: charset = utf-8
vim.opt.fileformat = "unix" -- editorconfig: end_of_line = lf

vim.opt.tabstop = 4 -- editorconfig: tab_width = 4
vim.opt.shiftwidth = 4 -- editorconfig: indent_size: 4
vim.opt.expandtab = false -- editorconfig: indent_style = tab
vim.opt.fixendofline = true -- editorconfig: insert_final_newline = true
vim.opt.endofline = true -- editorconfig: insert_final_newline = true

vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.list = true
vim.opt.listchars = { multispace = "·   ", tab = "> " }

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.backspace = "indent,eol,start"

vim.opt.clipboard:append("unnamedplus")

vim.opt.hlsearch = false
vim.opt.incsearch = true

-- vim.opt.splitright = true
-- vim.opt.splitbelow = true

vim.opt.iskeyword:append("-")

vim.g.netrw_browse_split = 0
-- vim.g.netrw_banner = 0
-- vim.g.netrw_winsize = 25
