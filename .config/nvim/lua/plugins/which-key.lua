require("which-key").setup({
	-- Your config here (empty for defaults)
})

-- Keymap to show buffer-local keymaps
vim.keymap.set("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
