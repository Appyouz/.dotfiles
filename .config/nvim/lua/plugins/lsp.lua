local M = {}

-- diagnostics
vim.diagnostic.config({
	virtual_text = { prefix = "●", spacing = 4 },
	severity_sort = true,
	float = { border = "rounded" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

-- floating border fix
do
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = "rounded"
		return orig(contents, syntax, opts, ...)
	end
end

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local buf = ev.buf
		local opts = { buffer = buf, silent = true }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "rn", vim.lsp.buf.rename, opts)
	end,
})

-- Mason setup
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"basedpyright",
		"clangd",
		"ts_ls",
		"html",
		"bashls",
		"marksman",
	},
	automatic_installation = true,
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
	},
})

require("fidget").setup({})

-- LSP servers (vim.lsp.config API)
-- local caps = vim.lsp.protocol.make_client_capabilities()
local caps = {}

pcall(function()
	caps = require("blink.cmp").get_lsp_capabilities()
end)

vim.lsp.config("lua_ls", {
	capabilities = caps,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	capabilities = caps,
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
			},
		},
	},
})

vim.lsp.config("clangd", {
	capabilities = caps,
	init_options = {
		fallbackFlags = { "-std=c++20" },
	},
	settings = {
		clangd = {
			-- Show documentation in a cleaner way
			completion = {
				detailedLabel = true,
			},
			-- Improve hover documentation
			hover = {
				showKinds = true,
			},
		},
	},
})

vim.lsp.config("ts_ls", { capabilities = caps })
vim.lsp.config("html", { capabilities = caps })
vim.lsp.config("bashls", { capabilities = caps })
vim.lsp.config("marksman", { capabilities = caps })

-- enable servers
vim.lsp.enable({
	"lua_ls",
	"basedpyright",
	"clangd",
	"ts_ls",
	"html",
	"bashls",
	"marksman",
})

return M
