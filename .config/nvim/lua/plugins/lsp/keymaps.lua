local M = {}

M._keys = nil

function M.get()
	local format = require("plugins.lsp.format").format
	if not M._keys then
		M._keys = {
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<c-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "gd", vim.lsp.buf.definition, desc = "Goto Definition" },
			{ "gr", vim.lsp.buf.references, desc = "Goto References" },
			{ "<leader>e", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			{ "<leader>rn", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", has = "codeAction" },
			{ "<leader>f", format, desc = "Format Document", has = "documentFormatting" },
			{ "<leader>f", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
		}
	end
	return M._keys
end

function M.on_attach(client, buffer)
	local Keys = require("lazy.core.handler.keys")
	local keymaps = {}

	for _, value in ipairs(M.get()) do
		local keys = Keys.parse(value)
		if keys[2] == vim.NIL or keys[2] == false then
			keymaps[keys.id] = nil
		else
			keymaps[keys.id] = keys
		end
	end

	for _, keys in pairs(keymaps) do
		if not keys.has or client.server_capabilities[keys.has .. "Provider"] then
			local opts = Keys.opts(keys)
			opts.has = nil
			opts.silent = true
			opts.buffer = buffer
			vim.keymap.set(keys.mode or "n", keys[1], keys[2], opts)
		end
	end
end

function M.diagnostic_goto(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end

return M
