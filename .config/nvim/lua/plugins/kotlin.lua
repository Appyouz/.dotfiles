-- require("kotlin").setup({
-- 	ft = { "kotlin" },
-- 	dependencies = {
-- 		"mason.nvim",
-- 		"mason-lspconfig.nvim",
-- 		"oil.nvim",
-- 		"trouble.nvim",
-- 	},
-- 	opts = {},
-- })
--

require("kotlin").setup({
	jdk_for_symbol_resolution = "/usr/lib/jvm/java-17-openjdk",
})
