require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	-- ensure_installed = { "crablang" },
	-- ignore_install = { "javascript" },
	sync_install = false,
	auto_install = true,
	additional_vim_regex_highlighting = false,
})
