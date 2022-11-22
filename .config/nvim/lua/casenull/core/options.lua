local opt = vim.opt

opt.fileencoding = "utf-8"

opt.number = true
opt.relativenumber = true
opt.scrolloff = 10

opt.tabstop = 4
opt.shiftwidth = 4
-- "Using spaces instead of tabs? That's like saying vim instead of emacs!"
opt.expandtab = true
opt.autoindent = true

-- I get why people hate this.
opt.wrap = true
opt.breakindent = true

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

