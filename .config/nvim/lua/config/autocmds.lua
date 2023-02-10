-- File Type Settings

local ftset = vim.api.nvim_create_augroup("FileTypeSettings", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.opt_local.filetype = "terraform"
	end,
	group = ftset,
})
