local function on_attach(o_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			o_attach(client, buffer)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"mfussenegger/nvim-jdtls",
		},
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},
			-- Automatically format on save
			autoformat = true,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overriden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			servers = {
				ansiblels = {},
				terraformls = {},
				tflint = {},
				bashls = {},
				cssls = {},
				eslint = {},
				html = {},
				pyright = {},
				texlab = {},
				yamlls = {},
				clangd = {},
				gopls = {},
				rust_analyzer = {},
				jdtls = {},
				tsserver = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				ltex = {
					settings = {
						ltex = {
							language = "en-US",
							checkFrequency = "save",
							additionalRules = {
								motherTongue = "de-CH",
							},
							disabledRules = {
								["en-US"] = { "UPPERCASE_SENTENCE_START", "PASSIVE_VOICE" },
								["de-CH"] = { "UPPERCASE_SENTENCE_START" },
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
				},
				taplo = {},
			},
			-- you can do any additional lsp server setup here (and?) return true if you don't want this server to be setup with lspconfig
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				ltex = function(_, opts)
					opts.handlers = {
						["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
							virtual_text = false, -- Disable virtual text
							signs = function(_, bufnr)
								return vim.b[bufnr].show_signs == false -- Disable signs
							end,
						}),
					}
				end,
				jdtls = function()
					-- Do not configure at all, nvim-jdtls does that
					return true
				end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},

		config = function(_, opts)
			require("plugins.lsp.format").autoformat = opts.autoformat
			-- setup formatting and keymaps
			on_attach(function(client, buffer)
				require("plugins.lsp.format").on_attach(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers) })
			require("mason-lspconfig").setup_handlers({
				function(server)
					local server_opts = servers[server] or {}
					server_opts.capabilities = capabilities

					if opts.setup[server] then
						if opts.setup[server](server, server_opts) then
							return
						end
					elseif opts.setup["*"] then
						if opts.setup["*"](server, server_opts) then
							return
						end
					end

					require("lspconfig")[server].setup(server_opts)
				end,
			})
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local null_ls = require("null-ls")
			return {
				sources = {
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.stylua,
				},
			}
		end,
	},

	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				"prettier",
				"stylua",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}
