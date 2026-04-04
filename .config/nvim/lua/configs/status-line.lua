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
	-- Note: If you have nvim-web-devicons installed, you could use that here
	-- but for native/lightweight we stick to the string
	return " " .. ft .. " "
end

-- Progress bar logic
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

-- 2. GLOBAL ACCESS
_G.st_mode = mode_label
_G.st_git = git_branch
_G.st_diag = diagnostics
_G.st_ft = file_type
_G.st_progress = progress_bar

-- 3. THEME-LINKED HIGHLIGHTS
local function set_hl()
	-- We link custom groups to theme's existing colors
	-- This ensures it changes switch colorschemes
	vim.api.nvim_set_hl(0, "St_Primary", { link = "CursorLineNr" }) -- The "Accent" (Mode/Progress)
	vim.api.nvim_set_hl(0, "St_Secondary", { link = "StatusLine" }) -- The "Body"
	vim.api.nvim_set_hl(0, "St_Ghost", { fg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg, bg = "NONE" })
end
set_hl()

-- 4. STATUSLINE GENERATOR
local function active_line()
	return table.concat({
		-- Left Section (Mode)
		"%#St_Primary# %{v:lua.st_mode()} ",

		-- Branch & Diagnostics (using standard statusline colors)
		"%#StatusLine#",
		"%{v:lua.st_git()}",
		"%{v:lua.st_diag()} ",

		-- Filename
		" %t %m %r",

		-- Spacer
		"%#Normal#%=",

		-- Right Section (Filetype & Progress)
		"%#StatusLine# %{v:lua.st_ft()} ",

		-- "%#StatusLine# %y ", -- %y shows filetype automatically
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
