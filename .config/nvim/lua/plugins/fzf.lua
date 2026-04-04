local fzf = require("fzf-lua")

fzf.setup({})

local keymaps = {
	{ "<leader>ff", fzf.files, "Find Files in project directory" },
	{ "<leader>fg", fzf.live_grep, "Find by grepping in project directory" },
	{ "<leader>fc", function()
		fzf.files({ cwd = vim.fn.stdpath("config") })
	end, "Find in neovim config" },
	{ "<leader>fh", fzf.helptags, "Find Help" },
	{ "<leader>fk", fzf.keymaps, "Find Keymaps" },
	{ "<leader>fb", fzf.builtin, "Find Builtin FZF" },
	{ "<leader>fw", fzf.grep_cword, "Find current word" },
	{ "<leader>fW", fzf.grep_cWORD, "Find current WORD" },
	{ "<leader>fd", fzf.diagnostics_document, "Find Diagnostics" },
	{ "<leader>fr", fzf.resume, "Resume last search" },
	{ "<leader>fo", fzf.oldfiles, "Find Old Files" },
	{ "<leader><leader>", fzf.buffers, "Find buffers" },
	{ "<leader>/", fzf.lgrep_curbuf, "Grep current buffer" },
}

for _, km in ipairs(keymaps) do
	vim.keymap.set("n", km[1], km[2], { desc = km[3] })
end
