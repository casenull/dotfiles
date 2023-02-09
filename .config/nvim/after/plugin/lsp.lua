require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

local lspconfig = require("lspconfig")

-- Defined in ../after/lsp-settings.lua
local lsp_settings = require("lsp-settings")

-- vim.diagnostic.config({ virtual_text = false, signs = true })

-- Install servers
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(lsp_settings.servers),
	automatic_installation = true,
})

-- Setup servers
mason_lspconfig.setup_handlers({
	function(server_name)
		local on_attach = lsp_settings.on_attach
		local handlers = vim.lsp.handlers
		-- Disable formatting for tsserver and html-language-server
		if server_name == "tsserver" or "html" then
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				lsp_settings.on_attach(client, bufnr)
			end
		end
		-- Disable virtual text for ltex
		if server_name == "ltex" then
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					virtual_text = false,
				}),
			}
		end
		lspconfig[server_name].setup({
			capabilities = lsp_settings.capabilities,
			on_attach = on_attach,
			settings = lsp_settings.servers[server_name],
			handlers = handlers,
		})
	end,

	["jdtls"] = function() end,
})
