require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	auto_install = true,
	sync_install = false,
	ensure_installed = {
		-- Generic
		"vim",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"help",
		"comment",
		"diff",
		-- Config
		"bash",
		"cmake",
		"dockerfile",
		"json",
		"jsonc",
		"make",
		"terraform",
		"toml",
		"yaml",
		-- Documentation
		"bibtex",
		"latex",
		"markdown",
		"markdown_inline",
		-- Code
		"c",
		"cpp",
		"css",
		"go",
		"gomod",
		"gowork",
		"html",
		"java",
		"javascript",
		"kotlin",
		"lua",
		"python",
		"regex",
		"rust",
		"sql",
	},
})
