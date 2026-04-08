vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/f4z3r/gruvbox-material.nvim",
	"https://github.com/ibhagwan/fzf-lua",
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
	},

	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/j-hui/fidget.nvim",
	{
		src = "https://github.com/saghen/blink.cmp",
		version = vim.version.range("1.*"),
	},
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/folke/which-key.nvim",

	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",

	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/stevearc/conform.nvim",
	"https://www.github.com/echasnovski/mini.nvim",

	"https://github.com/folke/snacks.nvim",

	"https://github.com/ThePrimeagen/vim-be-good",
})
require("plugins.oil")
require("plugins.gruvbox")
require("plugins.fzf")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.blink-cmp")
require("plugins.which-key")
require("plugins.render-markdown")
require("plugins.conform")
require("plugins.mini")
require("plugins.snacks")
