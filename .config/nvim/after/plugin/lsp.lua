require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

local lspconfig = require("lspconfig")

-- Defined in ../after/lsp-settings.lua
local lsp_settings = require("lsp-settings")

-- Install servers
mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(lsp_settings.servers),
	automatic_installation = true,
})

-- Setup servers
for server, config in pairs(lsp_settings.servers) do
	if config.disable_autostart == true then
		goto skip
	end

	local opts = {
		on_attach = lsp_settings.on_attach,
		capabilities = lsp_settings.capabilities,
	}

	if config.opts ~= nil then
		opts = vim.tbl_deep_extend("force", config.opts, opts)
	end

	lspconfig[server].setup(opts)
	::skip::
end

require("mason-null-ls").setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"ansiblelint",
		"yamllint",
		"hadolint",
		"jsonlint",
	},
})

local null_ls = require("null-ls")

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
	on_attach = lsp_settings.on_attach,
})
