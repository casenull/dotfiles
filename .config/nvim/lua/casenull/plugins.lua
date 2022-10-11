local install_path = vim.fn.stdpath "data".."/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system{
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path
  }
  print "Installing packer. Please restart nvim."
  vim.cmd [[packadd packer.nvim]]
end

local status, packer = pcall(require, "packer")
if (not status) then
  return
end

packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

packer.startup(function(use)
  use "wbthomason/packer.nvim"
  -- use "sheerun/vim-polyglot"
  -- Automatically pair parentheses
  use "windwp/nvim-autopairs"

  -- Colorscheme
  use "ellisonleao/gruvbox.nvim"
  use "EdenEast/nightfox.nvim"
  use "marko-cerovac/material.nvim"

  -- Comment controls
  use "numToStr/Comment.nvim"

  -- Completion
  use "hrsh7th/nvim-cmp"
  -- nvim-cmp source for buffer words
  use "hrsh7th/cmp-buffer"
  -- nvim-cmp source for filesystem paths
  use "hrsh7th/cmp-path"
  -- nvim-cmp source for LuaSnip
  use "saadparwaiz1/cmp_luasnip"
  -- nvim-cmp source for neovim's builtin language server client
  use "hrsh7th/cmp-nvim-lsp"
  -- nvim-cmp source for neovim Lua API
  use "hrsh7th/cmp-nvim-lua"
  -- use "kdheepak/cmp-latex-symbols"

  -- Snippets
  use "L3MON4D3/LuaSnip"
  -- use "rafamadriz/friendly-snippets"

  -- A file explorer for neovim written in lua
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {"kyazdani42/nvim-web-devicons"}
  }

  -- Bufferline
    use "akinsho/bufferline.nvim"
  -- use "nanozuki/tabby.nvim"

  -- Statusline
  use "feline-nvim/feline.nvim"

  -- Gitsigns
  use "lewis6991/gitsigns.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"

  -- LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"

  if packer_bootstrap then
    packer.sync()
  end
end)
