local jdtls_status, jdtls = pcall(require, "jdtls")
if not jdtls_status then
	return
end

local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

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

local keymap = vim.keymap

local on_attach = function(client, bufnr)
	-- https://github.com/mfussenegger/nvim-jdtls/blob/master/lua/jdtls/dap.lua#L577
	jdtls.setup_dap() -- Create new dap adapter for java

	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "<a-o>", "<cmd>lua require('jdtls').organize_imports()<cr>", opts)
	keymap.set("n", "crv", "<cmd>lua require('jdtls').extract_variable()<cr>", opts)
	keymap.set("v", "crv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", opts)
	keymap.set("n", "crc", "<cmd>lua require('jdtls').extract_constant()<cr>", opts)
	keymap.set("v", "crc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", opts)
	keymap.set("v", "crm", "<esc><cmd>lua require('jdtls').extract_method(true)<cr>", opts)

	keymap.set("n", "<leader>df", "<cmd>lua require('jdtls').test_class()<cr>", opts)
	keymap.set("n", "<leader>dn", "<cmd>lua require('jdtls').test_nearest_method()<cr>", opts)

	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
	keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
	keymap.set("n", "<space>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
	keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
	keymap.set("n", "gr", vim.lsp.buf.references, opts)
	keymap.set("n", "<space>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

jdtls.start_or_attach({
	-- ~/.local/share/nvim/mason/bin/jdtls
	cmd = { "jdtls" },
	root_dir = vim.fs.dirname(vim.fs.find({ "settings.gradle", ".git", "pom.xml" }, { upward = true })[1]),
	init_options = {
		bundles = bundles,
	},
	on_attach = on_attach,
})

dap.configurations.java = {
	{
		name = "Launch current file",
		type = "java",
		request = "launch",
		program = "${file}",
	},
}
