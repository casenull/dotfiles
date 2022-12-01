local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

mason.setup()

mason_lspconfig.setup({
	ensure_installed = {
		"ansiblels",
		"bashls",
		"cssls",
		"eslint",
		"html",
		"jdtls",
		"pyright",
		"sumneko_lua",
		"texlab",
		"tsserver",
		"yamlls",
		"clangd",
		"gopls",
	},
	automatic_installation = true,
})

local keymap = vim.keymap

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)
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

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Automatic setup of lsp servers
mason_lspconfig.setup_handlers({
	-- Default Server Configuration
	function(server_name)
		lspconfig[server_name].setup({
			on_attach = on_attach,
			capabilities = capabilities,
		})
	end,
	-- Custom Configurations
	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})
	end,
	-- Do not configure jdtls, use nvim-jdtls
	["jdtls"] = function() end,
})
