return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
	-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {

		render_modes = { "n", "c", "t" },

		checkbox = {
			unchecked = {
				icon = " ", -- Make this icon larger (use a bigger Nerd Font symbol)
				highlight = "RenderMarkdownUnchecked",
			},
			checked = {
				icon = " ", -- Make this icon larger
				highlight = "RenderMarkdownChecked",
			},
			-- Increase right padding to create more space around the checkbox
			right_pad = 2,
		},
	},
}
