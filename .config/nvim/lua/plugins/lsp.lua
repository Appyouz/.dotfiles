return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"ibhagwan/fzf-lua",
		"glepnir/lspsaga.nvim",
	},
	config = function()
		-- Auto-command for showing diagnostics on cursor hold
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = " ",
					scope = "cursor",
				}
				vim.diagnostic.open_float(nil, opts)
			end,
		})

		-- LSP flags
		local lsp_flags = {
			debounce_text_changes = 150,
		}

		-- On_attach function with key mappings
		local on_attach = function(client, bufnr)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			-- Lspsaga mappings (preserving old config features)
			map("gd", "<Cmd>Lspsaga finder<CR>", "[G]oto [D]efinition and References")
			map("K", "<Cmd>Lspsaga hover_doc<CR>", "Hover Documentation")
			map("<leader>ca", "<Cmd>Lspsaga code_action<CR>", "[C]ode [A]ction", { "n", "x" })
			map("[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous Diagnostic")
			map("]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic")
			map("<leader>rn", "<Cmd>Lspsaga rename<CR>", "[R]ename")
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
			map("<C-k>", "<Cmd>Lspsaga signature_help<CR>", "Signature Help", "i")

			-- Fzf-lua mappings from new config
			map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
			map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
			map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

			-- Workspace folder mappings
			map("<space>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
			map("<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
			map("<space>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, "List Workspace Folders")

			-- Formatting
			map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

			-- Document highlighting
			if client and client.server_capabilities.documentHighlightProvider then
				local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = bufnr,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
					buffer = bufnr,
					callback = function(event)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event.buf })
					end,
				})
			end

			-- Inlay hints
			if client and client.server_capabilities.inlayHintProvider then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
				end, "[T]oggle Inlay [H]ints")
			end
		end

		-- Diagnostic configuration
		vim.diagnostic.config({
			severity_sort = true,
			float = {
				border = "rounded",
				source = "always",
				focusable = false,
				style = "minimal",
				header = "",
				prefix = "",
			},
			underline = { severity = vim.diagnostic.severity.ERROR },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
			virtual_text = {
				source = "if_many",
				spacing = 4,
				prefix = "●",
			},
		})

		-- Base capabilities
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- Server configurations
		local servers = {
			bashls = { on_attach = on_attach, flags = lsp_flags, capabilities = capabilities },
			marksman = { on_attach = on_attach, flags = lsp_flags, capabilities = capabilities },
			clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				single_file_support = true,
				on_attach = on_attach,
				capabilities = vim.tbl_deep_extend("force", capabilities, { offsetEncoding = "utf-8" }),
				flags = lsp_flags,
				root_dir = require("lspconfig").util.root_pattern(
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git"
				),
				init_options = { fallbackFlags = { "-std=c++2a" } },
			},
			basedpyright = {
				cmd = { "basedpyright-langserver", "--stdio" },
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							typeCheckingMode = "standard",
						},
					},
				},
			},
			jinja_lsp = { on_attach = on_attach, flags = lsp_flags, capabilities = capabilities },
			lua_ls = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},
			emmet_ls = {
				cmd = { "emmet-ls", "--stdio" },
				filetypes = {
					"astro",
					"css",
					"eruby",
					"html",
					"htmldjango",
					"javascriptreact",
					"less",
					"pug",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
					"vue",
					"htmlangular",
				},
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
			ts_ls = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = {
					typescript = {
						inlayHints = {
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = false,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayVariableTypeHints = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayEnumMemberValueHints = true,
						},
					},
				},
			},
			html = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				provideFormatter = true,
				filetypes = { "html", "htmldjango" },
			},
			cmake = {
				cmd = { "cmake-language-server" },
				filetypes = { "cmake" },
				init_options = { buildDirectory = "build" },
				root_dir = require("lspconfig").util.root_pattern(
					"CMakePresets.json",
					"CTestConfig.cmake",
					".git",
					"build",
					"cmake"
				),
				single_file_support = true,
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
			gopls = {
				cmd = { "gopls" },
				filetypes = { "go", "gomod", "gowork", "gotmpl" },
				root_dir = require("lspconfig").util.root_pattern("go.mod", ".git"),
				single_file_support = true,
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
		}

		-- Mason tool installer setup
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, { "stylua", "prettierd", "clang-format" })
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		-- Mason and LSP config setup
		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {},
			automatic_installation = false,
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})

		-- Lspsaga setup (for file header feature)
		require("lspsaga").setup({
			server_filetype_map = { typescript = "typescript" },
			scroll_preview = { scroll_down = "<C-f>", scroll_up = "<C-b>" },
			definition = { edit = "<CR>" },
			ui = {
				winblend = 10,
				border = "rounded",
				colors = { normal_bg = "#002b36" },
			},
		})
	end,
}
