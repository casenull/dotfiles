local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
	return
end

-- Defined in ../after/lsp-settings.lua
local lsp_settings = require("lsp-settings")

local bundles = vim.list_extend(
	{
		-- Mason: java-debug-adapter
		vim.fn.glob(
			"~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
			1
		),
	},
	-- Mason: java-test
	vim.split(vim.fn.glob("~/.local/share/nvim/mason/packages/java-test/extension/server/*.jar", 1), "\n")
)

local on_attach = function(client, bufnr)
	-- https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls/dap.lua#L577
	jdtls.setup_dap() -- Create new dap adapter for java

	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- nvim-jdtls specific mappings
	vim.keymap.set("n", "<a-o>", jdtls.organize_imports, opts)
	vim.keymap.set("n", "crv", jdtls.extract_variable, opts)
	vim.keymap.set("v", "crv", jdtls.extract_variable, opts)
	vim.keymap.set("n", "crc", jdtls.extract_constant, opts)
	vim.keymap.set("v", "crc", jdtls.extract_constant, opts)
	vim.keymap.set("v", "crm", jdtls.extract_method, opts)

	vim.keymap.set("n", "<leader>df", jdtls.test_class, opts)
	vim.keymap.set("n", "<leader>dn", jdtls.test_nearest_method, opts)

	lsp_settings.on_attach(client, bufnr)
end

jdtls.start_or_attach({
	-- ~/.local/share/nvim/mason/bin/jdtls
	cmd = { "jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "settings.gradle", ".git", "pom.xml" }, { upward = true })[1]),
	init_options = {
		bundles = bundles,
	},
	on_attach = on_attach,
	capabilities = lsp_settings.capabilities,
})

local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

dap.configurations.java = {
	{
		name = "Launch current file",
		type = "java",
		request = "launch",
		program = "${file}",
	},
}
