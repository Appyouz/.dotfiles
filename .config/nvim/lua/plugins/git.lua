return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({})
		end,
	},

	{
		"dinhhuy258/git.nvim",
		config = function()
			require("git").setup({
				keymaps = {
					-- Open blame window
					blame = "<Leader>gb",
					-- Open file/folder in git repository
					browse = "<Leader>go",
				},
			})
		end,
	},
}
