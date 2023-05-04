return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Git Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fl", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "<leader>fp", "<cmd>Telescope diagnostics<cr>", desc = "LSP Diagnostics" },
	},
}
