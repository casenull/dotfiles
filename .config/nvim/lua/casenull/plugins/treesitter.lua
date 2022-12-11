local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	ensure_installed = {
		"java",
		"python",
		"html",
		"css",
		"javascript",
		"markdown",
		"lua",
		"latex",
		"c",
		"cpp",
	},
	auto_install = true,
})
