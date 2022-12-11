local opt = vim.opt

opt.fileencoding = "utf-8" -- editorconfig: charset = utf-8
opt.fileformat = "unix" -- editorconfig: end_of_line = lf

opt.tabstop = 4 -- editorconfig: tab_width = 4
opt.shiftwidth = 4 -- editorconfig: indent_size: 4
opt.expandtab = false -- editorconfig: indent_style = tab
opt.fixendofline = true -- editorconfig: insert_final_newline = true
opt.endofline = true -- editorconfig: insert_final_newline = true

opt.wrap = true
opt.breakindent = true
opt.autoindent = true
opt.list = true
opt.listchars = { multispace = "·   ", tab = "> " }

opt.number = true
opt.relativenumber = true
opt.scrolloff = 10

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
