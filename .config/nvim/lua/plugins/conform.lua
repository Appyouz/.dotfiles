local ok, conform = pcall(require, "conform")
if not ok then
	return
end

conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },

		python = { "isort", "black" },

		javascript = { "prettierd", "prettier", stop_after_first = true },
		typescript = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		css = { "prettierd", "prettier", stop_after_first = true },

		c = { "clang-format" },
		cpp = { "clang-format" },

		rust = { "rustfmt" },
		go = { "goimports", "gofmt" },
	},

	-- clean and predictable behavior
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},

	notify_on_error = true,
})
