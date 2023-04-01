return {
	-- EditorConfig Support
	-- Can be removed in neovim 0.9
	{
		"gpanders/editorconfig.nvim",
		lazy = false,
	},

	-- Allows for quick (un)commenting
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- Indentlines
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			char = "│",
			filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
			show_current_context = true,
		},
	},

	-- Git integration for editor
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup()
		end,
	},

	-- Pretty colors
	{
		"brenoprata10/nvim-highlight-colors",
		event = { "BufReadPre", "BufNewFile" },
		config = true,
	},

	{
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor()
				end,
				"v",
				desc = "Prompt for refactor",
			},
		},
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
	},

	{
		"jbyuki/instant.nvim",
		lazy = false,
		config = function()
			vim.cmd("let g:instant_username = 'casenull'")
		end,
	},
}
