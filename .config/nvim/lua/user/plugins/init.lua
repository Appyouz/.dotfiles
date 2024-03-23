return {
	-- require("plugins.lsp.lsp-config"),

	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup()
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"preservim/tagbar",
	},
	{
		"RRethy/vim-illuminate",
	},
	{
		"folke/twilight.nvim",
	},
}
