local gruvbox = require("gruvbox-material")

gruvbox.setup({
	contrast = "hard",
	customize = function(group, opts)
		local colors = require("gruvbox-material.colors").get(vim.o.background, "hard")

		if group == "CursorLineNr" then
			opts.link = nil
			opts.fg = colors.orange
			opts.bold = true
			return opts
		end

		if group == "MatchParen" or group == "MatchParenCur" or group == "MatchWord" then
			opts.link = nil
			opts.fg = colors.orange
			opts.bg = nil
			opts.bold = true
			return opts
		end

		if group == "Pmenu" or group == "NormalFloat" then
			opts.bg = colors.bg3
		end

		if group == "PmenuSel" then
			opts.bg = colors.yellow
		end

		if group == "CmpItemAbbrMatch" or group == "CmpItemAbbrMatchFuzzy" then
			opts.fg = colors.orange
		end

		if group == "Search" then
			opts.bg = colors.aqua
		end

		if group == "IncSearch" then
			opts.bg = colors.orange
		end

		return opts
	end,
})

vim.opt.background = "dark"
vim.cmd.colorscheme("gruvbox-material")
