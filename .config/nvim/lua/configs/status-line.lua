-- Git branch with 5s caching
local cached_branch = ""
local last_check = 0
local function git_branch()
	local now = vim.loop.now()
	if now - last_check > 5000 then
		cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		last_check = now
	end
	return (cached_branch ~= "") and ("  " .. cached_branch .. " ") or ""
end

-- LSP Diagnostics
local function diagnostics()
	local count = {
		e = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }),
		w = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN }),
	}
	local str = ""
	if count.e > 0 then
		str = str .. "  " .. count.e
	end
	if count.w > 0 then
		str = str .. "  " .. count.w
	end
	return str
end

-- File type with icons
local function file_type()
	local ft = vim.bo.filetype
	if ft == "" then
		return "   "
	end
	return " " .. ft .. " "
end

-- Line and Column numbers
local function line_col()
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	local total_lines = vim.fn.line("$")
	return string.format(" %d:%d/%d ", line, col, total_lines)
end

-- UTF-8 indicator
local function utf_indicator()
	-- Check if current buffer is UTF-8
	local enc = vim.bo.fileencoding
	if enc == "utf-8" or enc == "utf8" then
		return " UTF-8 "
	elseif enc == nil or enc == "" then
		return ""
	else
		return " " .. string.upper(enc) .. " "
	end
end

-- Progress bar
local function progress_bar()
	local curr = vim.fn.line(".")
	local total = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local index = math.ceil((curr / total) * #chars)
	return chars[index] or chars[1]
end

local function mode_label()
	local m = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK",
		c = "COMMAND",
		R = "REPLACE",
		t = "TERM",
	}
	return modes[m] or m
end

--  GLOBAL ACCESS
_G.st_mode = mode_label
_G.st_git = git_branch
_G.st_diag = diagnostics
_G.st_ft = file_type
_G.st_progress = progress_bar
_G.st_line_col = line_col
_G.st_utf = utf_indicator

--  Theme Linked HighLights
local function set_hl()
	-- link custom groups to theme's existing colors
	-- This ensures it changes switch colorschemes
	vim.api.nvim_set_hl(0, "St_Primary", { link = "CursorLineNr" })
	vim.api.nvim_set_hl(0, "St_Secondary", { link = "StatusLine" })
	vim.api.nvim_set_hl(0, "St_Ghost", { fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg, bg = "NONE" })
	vim.api.nvim_set_hl(0, "St_Info", { link = "Comment" })
end
set_hl()

local function active_line()
	return table.concat({
		"%#St_Primary# %{v:lua.st_mode()} ",

		"%#StatusLine#",
		"%{v:lua.st_git()}",
		"%{v:lua.st_diag()} ",

		-- Filename
		" %t %m %r",

		"%#Normal#%=",

		-- Right Section (UTF, Line/Col, Filetype & Progress)
		"%#St_Info#%{v:lua.st_utf()}",
		"%#StatusLine#%{v:lua.st_line_col()}",
		"%{v:lua.st_ft()} ",

		-- Progress bar
		"%#St_Primary# %{v:lua.st_progress()} ",
	})
end

local function inactive_line()
	return " %t %m %r %="
end

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "ColorScheme" }, {
	callback = function()
		set_hl()
		vim.opt_local.statusline = active_line()
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.opt_local.statusline = inactive_line()
	end,
})

-- Initial load
vim.opt.statusline = active_line()
