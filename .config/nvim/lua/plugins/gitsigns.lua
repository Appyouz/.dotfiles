local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
	return
end

gitsigns.setup({
	signs = {
		add = { text = "▏" },
		change = { text = "▏" },
		delete = { text = "▏" },
		topdelete = { text = "▔" },
		changedelete = { text = "●" },
		untracked = { text = "○" },
	},

	signcolumn = true,
	current_line_blame = false,
})

-- keymaps 
local map = vim.keymap.set
local gs = gitsigns

map("n", "]h", gs.next_hunk, { desc = "Next git hunk" })
map("n", "[h", gs.prev_hunk, { desc = "Previous git hunk" })

map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })

map("n", "<leader>hb", function()
	gs.blame_line({ full = true })
end, { desc = "Blame line" })

map("n", "<leader>hB", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })

map("n", "<leader>hd", gs.diffthis, { desc = "Diff this" })
