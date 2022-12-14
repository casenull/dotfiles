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

local lsp_settings = require("lsp-settings")

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
