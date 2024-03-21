return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = { "lua", "cpp" },
			sync_install = false,
			auto_install = true,
			highlight = { enable = true },
			autopairs = { enable = true },
			indent = { enable = true },
		})
	end,
}
