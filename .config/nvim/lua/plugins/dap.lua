return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"jay-babu/mason-nvim-dap.nvim",
			"leoluz/nvim-dap-go",
			"mxsdev/nvim-dap-vscode-js",
		},
		init = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
		end,
		keys = {
			-- stylua: ignore
			{ "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
			-- stylua: ignore
			{ "<leader>dK", function() require("dapui").eval() end, desc = "DAP UI Eval" },
			-- stylua: ignore
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint" },
			-- stylua: ignore
			{ "<leader>dc", function() require("dap").continue() end, desc = "DAP Continue" },
			-- stylua: ignore
			{ "<leader>di", function() require("dap").step_into() end, desc = "DAP Step Into" },
			-- stylua: ignore
			{ "<leader>do", function() require("dap").step_over() end, desc = "DAP Step Over" },
			-- stylua: ignore
			{ "<leader>dO", function() require("dap").step_out() end, desc = "DAP Step Out" },
			-- stylua: ignore
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP Toggle Repl" },
			-- stylua: ignore
			{ "<leader>dl", function() require("dap").run_last() end, desc = "DAP Run Last" },
			-- stylua: ignore
			{ "<leader>dt", function() require("dap").terminate() end, desc = "DAP Terminate" },
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = {
					"javadbg",
					"javatest",
					"python",
					"delve",
				},
				automatic_setup = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			require("dapui").setup({
				layouts = {
					{
						elements = {
							{ id = "console", size = 0.5 },
							{ id = "repl", size = 0.5 },
						},
						size = 0.25,
						position = "bottom",
					},
					{
						elements = {
							"scopes",
							"stacks",
							"breakpoints",
							"watches",
						},
						size = 0.25,
						position = "right",
					},
				},
			})

			require("dap-go").setup()

			require("dap-vscode-js").setup({
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				adapters = { "pwa-node" },
			})

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
				}
			end
		end,
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
	},
}
