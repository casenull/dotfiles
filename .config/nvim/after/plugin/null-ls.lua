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
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.yamllint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.ansiblelint,
		null_ls.builtins.diagnostics.jsonlint,
	},
	on_attach = lsp_settings.on_attach,
})
