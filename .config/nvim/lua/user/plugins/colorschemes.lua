-- vim.cmd.colorscheme("gruvbox-material")
return {
	{
		"sainnhe/gruvbox-material",
		config = function()
			-- Values: 'hard', 'medium' (default), 'soft'
			vim.g.gruvbox_material_background = "hard"

			-- For better performance
			vim.g.gruvbox_material_better_performance = 1
			-- vim.g.gruvbox_material_transparent_background = 2
		end,
	},
	{
		"morhetz/gruvbox",
		config = function()
			-- vim.cmd.colorscheme("gruvbox")
      vim.g.gruvbox_contrast_dark = "soft"
		end,
	},
}
