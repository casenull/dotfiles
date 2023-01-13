local M = {}

M.servers = {
	["ansiblels"] = {},
	["bashls"] = {},
	["cssls"] = {},
	["eslint"] = {},
	["html"] = {},
	["pyright"] = {},
	["texlab"] = {},
	["yamlls"] = {},
	["clangd"] = {},
	["gopls"] = {},
	["rust_analyzer"] = {},
	["jdtls"] = {},
	["tsserver"] = {},
	["sumneko_lua"] = {
		Lua = {
			format = {
				enable = false,
			},
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
	["ltex"] = {
		ltex = {
			language = "en-US",
			-- dictionary = {
			-- 	["en-US"] = ":/path/to/file.txt" or {},
			-- },
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "de-CH",
			},
			latex = {
				commands = {
					["\\newmintedfile[]{}{}"] = "ignore",
					["\\lstset{}"] = "ignore",
					["\\lstinline[]{}"] = "ignore",
					["\\lstinputlisting[]{}"] = "ignore",
					["\\lstdefinestyle{}{}"] = "ignore",
					["\\lstdefinelanguage{}{}"] = "ignore",
				},
			},
		},
	},
}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, opts)
	vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	if client.supports_method("textDocument/formatting") then
		vim.keymap.set("n", "<leader>f", function()
			vim.lsp.buf.format({ bufnr = bufnr, async = true })
		end, opts)

		-- This allows me to toggle LSP formatting
		vim.api.nvim_buf_create_user_command(bufnr, "LspToggleFormatting", function()
			if vim.tbl_isempty(vim.api.nvim_get_autocmds({ group = "LspFormatting" })) then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr, async = true })
					end,
				})
			else
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			end
		end, {})
		vim.api.nvim_command("LspToggleFormatting")
	end
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_status then
	M.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
else
	M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

return M
