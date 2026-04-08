require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

local parsers = {
	"vim",
	"vimdoc",
	"rust",
	"c",
	"cpp",
	"go",
	"html",
	"css",
	"javascript",
	"json",
	"lua",
	"markdown",
	"python",
	"typescript",
	"vue",
	"svelte",
	"bash",
}

-- install parsers
require("nvim-treesitter").install(parsers)

-- safe enable Treesitter per buffer
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		-- hard skip for Oil buffers
		if vim.bo[args.buf].filetype == "oil" then
			return
		end

		-- skip special/plugin buffers
		local skip_filetypes = {
			"fidget",
			"qf",
			"help",
			"startuptime",
			"lspinfo",
			"neo-tree",
			"TelescopePrompt",
			"NvimTree",
			"oil",
		}
		if vim.tbl_contains(skip_filetypes, vim.bo[args.buf].filetype) then
			return
		end

		-- only start if language exists in our installed parsers
		local ft = args.match
		if not vim.tbl_contains(parsers, ft) then
			return
		end

		-- try to start Treesitter safely
		local ok, err = pcall(vim.treesitter.start, args.buf, ft)
		if not ok then
			vim.schedule(function()
				vim.notify("Treesitter failed for " .. ft .. ": " .. err, vim.log.levels.WARN, { title = "Treesitter" })
			end)
		end
	end,
})

-- indent (safe version, per-buffer)
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		-- only set indent for supported filetypes
		local ft = args.match
		if vim.tbl_contains(parsers, ft) then
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})
