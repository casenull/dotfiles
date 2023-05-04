local reassign = {
	terraform = { "*.tf", ".tfvars" },
	django = { "*.j2" },
	sql = { "*.cql" },
}

local ftset = vim.api.nvim_create_augroup("FileTypeSettings", {})

for ft, pt in pairs(reassign) do
	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		pattern = pt,
		callback = function()
			vim.opt_local.filetype = ft
		end,
		group = ftset,
	})
end

vim.api.nvim_create_user_command("AutoFormat", function()
	local fmt = require("plugins.lsp.format")
	fmt.toggle()
	vim.notify("Auto formatting " .. (fmt.autoformat and "enabled" or "disabled"))
end, {})
