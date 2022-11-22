vim.g.mapleader = " "

local keymap = vim.keymap
local opts = { silent = true }

keymap.set("n", "<leader>nh", "<cmd>nohl<cr>", opts)

keymap.set("n", "<leader>sv", "<c-w>v", opts)
keymap.set("n", "<leader>sh", "<c-w>s", opts)
keymap.set("n", "<leader>se", "<c-w>=", opts)
keymap.set("n", "<leader>sx", "<cmd>close<cr>", opts)

keymap.set("n", "<leader>to", "<cmd>tabnew<cr>", opts)
keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", opts)
keymap.set("n", "<leader>tn", "<cmd>tabn<cr>", opts)
keymap.set("n", "<leader>tp", "<cmd>tabp<cr>", opts)

keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", opts)

keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts)
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts)
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)

keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>", opts)
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>", opts)
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>", opts)
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>", opts)

keymap.set("n", "<leader>rs", "<cmd>LspRestart<cr>", opts)

-- DAP
keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
keymap.set("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

