local reassign = {
	terraform = { "*.tf", ".tfvars" },
	django = { "*.j2" },
	sql = { "*.cql" },
	typst = { "*.typ" },
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

local yaml_means_ansible = false

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.yaml", "*.yml" },
	callback = function()
		if yaml_means_ansible then
			vim.opt_local.filetype = "yaml.ansible"
		else
			vim.opt_local.filetype = "yaml"
		end
	end,
	group = ftset,
})

vim.api.nvim_create_user_command("Ansible", function()
	yaml_means_ansible = not yaml_means_ansible
	vim.notify("YAML interpretation as Ansible " .. (yaml_means_ansible and "enabled" or "disabled"))
	if yaml_means_ansible and vim.opt_local.filetype == "yaml" then
		vim.opt_local.filetype = "yaml.ansible"
	else
		if vim.opt_local.filetype == "yaml.ansible" then
			vim.opt_local.filetype = "yaml"
		end
	end
end, {})
