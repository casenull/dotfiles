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

local status_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not status_mason_null_ls then
	return
end

local status_null_ls, null_ls = pcall(require, "null-ls")
if not status_null_ls then
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

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"ansiblelint",
		"yamllint",
		"hadolint",
		"jsonlint",
	},
})

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- Filter is a boolean, running format only if true
			return client.name ~= "tsserver" -- Use prettier instead
				and client.name ~= "sumneko_lua" -- Use stylua instead
		end,
		bufnr = bufnr,
		async = true,
	})
end

local keymap = vim.keymap

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
	keymap.set("n", "K", vim.lsp.buf.hover, opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap.set("n", "gr", vim.lsp.buf.references, opts)
	if client.supports_method("textDocument/formatting") then
		keymap.set("n", "<leader>f", function()
			lsp_formatting(bufnr)
		end, opts)
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end,
		})
	end
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

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier.with({
			extra_args = function(params)
				return params.options
					and params.options.tabSize
					and {
						"--tab-width",
						params.options.tabSize,
						"--trailing-comma",
						"all",
					}
			end,
		}),
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.ansiblelint,
		null_ls.builtins.diagnostics.jsonlint,
	},
	on_attach = on_attach,
})
