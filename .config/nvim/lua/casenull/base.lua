vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.wo.number = true                -- line numbers

vim.opt.clipboard = "unnamedplus"   -- use system clipboard (Thank you Fabio)
vim.opt.title = true                -- nvim can set the terminal title
vim.opt.autoindent = true           -- indent new line == indent previous line
vim.opt.hlsearch = true             -- highlight searches
vim.opt.backup = false              -- disable backup before override
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.backspace = "indent,eol,start"
vim.opt.textwidth = 80
vim.opt.formatoptions:append { "cqt" }
