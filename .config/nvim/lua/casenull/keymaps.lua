-- Reload init.lua 
vim.keymap.set("", "<Space>", "<Nop>", { silent = true})
vim.g.mapleader = ","

vim.keymap.set("n", "<leader><leader>", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })
