return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.1",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Files" },
		{ "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Files" },
	},
}
