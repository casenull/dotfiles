vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "Q", "<nop>")

-- Center when jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Toggle list mode, this should be done by a indentlines plugin...
local function toggleListMode()
	-- if vim.api.nvim_get_option_value("list", { scope = "global" }) then
	if vim.opt.list._value then
		vim.opt.list = false
	else
		vim.opt.list = true
	end
end

vim.api.nvim_create_user_command("HolyWar", toggleListMode, {})
