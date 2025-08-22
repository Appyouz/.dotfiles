return {
	{
		"Exafunction/windsurf.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"saghen/blink.cmp", -- Changed dependency to blink.cmp
		},
		config = function()
			require("codeium").setup({
				-- enable_cmp_source = true, -- Ensure windsur feeds completions to nvim-cmp (now blink.cmp)
				virtual_text = {
					-- enabled = true, -- Disable virtual text to avoid conflicts with blink.cmp
					enabled = false,
				},
			})
		end,
	},
}
