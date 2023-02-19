local M = {}

-- User dictionary for ltex-ls (Thanks github.com/David-Else)
-- https://github.com/valentjn/ltex-ls/issues/124
local words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/words.txt", "r"):lines() do
	table.insert(words, word)
end

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
	["lua_ls"] = {
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
			checkFrequency = "save",
			dictionary = {
				["de-CH"] = words,
			},
			additionalRules = {
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

	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ bufnr = bufnr, async = true })
	end, opts)
end

local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_status then
	M.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
else
	M.capabilities = vim.lsp.protocol.make_client_capabilities()
end

return M
