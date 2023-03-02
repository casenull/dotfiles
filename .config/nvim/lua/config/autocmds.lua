-- File Type Settings

local ftset = vim.api.nvim_create_augroup("FileTypeSettings", {})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.tf", "*.tfvars" },
	callback = function()
		vim.opt_local.filetype = "terraform"
	end,
	group = ftset,
})

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
	vim.notify("Ansible mode: " .. (yaml_means_ansible and "ON" or "OFF"))
	if yaml_means_ansible and vim.opt_local.filetype == "yaml" then
		vim.opt_local.filetype = "yaml.ansible"
	else
		if vim.opt_local.filetype == "yaml.ansible" then
			vim.opt_local.filetype = "yaml"
		end
	end
end, {})
