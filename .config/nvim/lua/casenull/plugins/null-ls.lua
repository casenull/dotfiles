local status_null_ls, null_ls = pcall(require, "null-ls")
if not status_null_ls then
	return
end

local status_mason_null_ls, mason_null_ls = pcall(require, "mason-null-ls")
if not status_mason_null_ls then
	return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

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
	},
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<leader>pf", function()
				vim.lsp.buf.format({ bufnr = bufnr })
			end, { buffer = bufnr })

			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
		"ansiblelint",
		"yamllint",
		"hadolint",
	},
})
