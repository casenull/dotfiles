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
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.prettier.with({
			extra_args = { "--tab-width", "4", "--trailing-comma", "all" },
			-- disabled_filetypes = {},
		}),
		null_ls.builtins.formatting.stylua,
	},
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

mason_null_ls.setup({
	ensure_installed = {
		"prettier",
		"stylua",
	},
})
