local ok, blink = pcall(require, "blink.cmp")
if not ok then
	vim.notify("blink.cmp failed to load", vim.log.levels.WARN)
	return
end

blink.setup({
	keymap = {
		preset = "default",
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	completion = {
		menu = { auto_show = true },
	},

	sources = {
		default = { "lsp", "path", "buffer", "snippets" },
	},

	snippets = {
		expand = function(snippet)
			local ok_luasnip, luasnip = pcall(require, "luasnip")
			if ok_luasnip then
				luasnip.lsp_expand(snippet)
			else
				vim.snippet.expand(snippet)
			end
		end,
	},

	fuzzy = {
		implementation = "lua",
	},
})
