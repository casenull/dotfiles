local dap_status, dap = pcall(require, "dap")
if not dap_status then
	return
end

local mason_dap_status, mason_dap = pcall(require, "mason-nvim-dap")
if not mason_dap_status then
	return
end

local dap_ui_status, dap_ui = pcall(require, "dapui")
if not dap_ui_status then
	return
end

local dap_virtual_text_status, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if not dap_virtual_text_status then
	return
end

-- Keybindings
vim.keymap.set("n", "<leader>du", dap_ui.toggle, {})
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, {})
vim.keymap.set("n", "<leader>dc", dap.continue, {})
vim.keymap.set("n", "<leader>di", dap.step_into, {})
vim.keymap.set("n", "<leader>do", dap.step_over, {})
vim.keymap.set("n", "<leader>dO", dap.step_out, {})
vim.keymap.set("n", "<leader>dr", dap.repl.toggle, {})
vim.keymap.set("n", "<leader>dl", dap.run_last, {})
vim.keymap.set("n", "<leader>dt", dap.terminate, {})

-- vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })

mason_dap.setup({
	ensure_installed = {
		"javadbg",
		"javatest",
		"python",
		"firefox",
		"delve",
	},
	automatic_setup = true,
})

mason_dap.setup_handlers({
	-- Default Configuration
	function(source_name)
		require("mason-nvim-dap.automatic_setup")(source_name)
	end,
})

dap_ui.setup({
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

dap_virtual_text.setup({})
