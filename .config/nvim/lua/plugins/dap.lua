return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		init = function()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			-- dap.listeners.before.event_terminated["dapui_config"] = function()
			-- 	dapui.close()
			-- end
			-- dap.listeners.before.event_exited["dapui_config"] = function()
			-- 	dapui.close()
			-- end
		end,
		keys = {
			-- stylua: ignore
			{ "<leader>du", function() require("dapui").toggle() end, desc = "DAP UI Toggle" },
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
		opts = {
			ensure_installed = {
				"javadbg",
				"javatest",
				"python",
				"delve",
			},
			automatic_setup = true,
		},
		config = function(_, opts)
			require("mason-nvim-dap").setup(opts)

			require("mason-nvim-dap").setup_handlers({
				function(source_name)
					require("mason-nvim-dap.automatic_setup")(source_name)
				end,
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
		end,
	},
}
