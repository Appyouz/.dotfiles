-- Wait for plugin to load
vim.defer_fn(function()
	local ok, markdown = pcall(require, "render-markdown")
	if not ok then
		vim.notify("render-markdown.nvim not loaded", vim.log.levels.WARN)
		return
	end

	markdown.setup({
		render_modes = { "n", "c", "t" },
		checkbox = {
			unchecked = {
				icon = " ",
				highlight = "RenderMarkdownUnchecked",
			},
			checked = {
				icon = " ",
				highlight = "RenderMarkdownChecked",
			},
			right_pad = 2,
		},
	})
end, 100)
