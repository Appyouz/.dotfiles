return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "williamboman/mason.nvim", opts = {} },
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
		"ibhagwan/fzf-lua",
	},
	config = function()
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

		-- Define lsp_flags
		local lsp_flags = {
			-- This is the default in Nvim v0.7+
			debounce_text_changes = 150,
		}

		-- Define on_attach function
		local on_attach = function(client, bufnr)
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
			end

			-- Common LSP key mappings (using built-in Neovim LSP functions)
			map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
			map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")
			map("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
			map("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
			map("<leader>ds", vim.lsp.buf.document_symbol, "[D]ocument [S]ymbols")
			map("<leader>ws", vim.lsp.buf.workspace_symbol, "[W]orkspace [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
			map("<leader>cl", vim.lsp.buf.declaration, "[C]ode [L]ocation")
			map("<leader>cf", vim.lsp.buf.format, "[C]ode [F]ormat")

			-- Key mappings using fzf-lua (keeping your original mappings)
			map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
			map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
			map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
			map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
			map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
			map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")

			local function client_supports_method(client, method, bufnr)
				if vim.fn.has("nvim-0.11") == 1 then
					return client:supports_method(method, bufnr)
				else
					return client.supports_method(method, { bufnr = bufnr })
				end
			end

			if
				client
				and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, bufnr)
			then
				local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
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
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					buffer = bufnr,
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, bufnr) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
				end, "[T]oggle Inlay [H]ints")
			end

			if client and client:supports_method("textDocument/completion") then
				vim.lsp.completion.enable(true, client.id, bufnr)
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client then
					on_attach(client, event.buf)
				end
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
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
				spacing = 2,
				format = function(diagnostic)
					local diagnostic_message = {
						[vim.diagnostic.severity.ERROR] = diagnostic.message,
						[vim.diagnostic.severity.WARN] = diagnostic.message,
						[vim.diagnostic.severity.INFO] = diagnostic.message,
						[vim.diagnostic.severity.HINT] = diagnostic.message,
					}
					return diagnostic_message[diagnostic.severity]
				end,
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()

		local servers = {
			bashls = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
			marksman = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
			clangd = {
				cmd = { "clangd" },
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
				single_file_support = true,
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
				root_markers = {
					".clangd",
					".clang-tidy",
					".clang-format",
					"compile_commands.json",
					"compile_flags.txt",
					"configure.ac",
					".git",
				},
				init_options = { fallbackFlags = { "-std=c++2a" } },
			},
			pyright = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				cmd = { "pyright-langserver", "--stdio" },
				filetypes = { "python" },
				single_file_support = true,
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
							-- typeCheckingMode = "strict",
							autoImportCompletions = true,
							diagnosticSeverityOverrides = { -- Added for finer control
								reportUnusedVariable = "warning",
								reportUndefinedVariable = "error",
							},
						},
					},
				},
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

			jinja_lsp = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
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
						telemetry = { enable = false }, -- Added to disable telemetry
					},
				},
			},
			emmet_ls = {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = lsp_flags,
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
			},
			ts_ls = {
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = { -- Added inlay hints
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
				capabilities = capabilities,
				flags = lsp_flags,
				provideFormatter = true, -- Added for built-in formatting
			},
			cmake = {
				cmd = { "cmake-language-server" },
				filetypes = { "cmake" },
				init_options = { buildDirectory = "build" },
				root_markers = {
					"CMakePresets.json",
					"CTestConfig.cmake",
					".git",
					"build",
					"cmake",
				},
				single_file_support = true,
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
			},
			-- End of server configs
		}

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua",
			"prettierd",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
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

		vim.opt.completeopt = { "menuone", "noselect", "popup" }
		vim.keymap.set("i", "<c-space>", vim.lsp.completion.get)
		vim.keymap.set("i", "<cr>", "pumvisible() ? '<c-y>' : '<cr>'", { expr = true })
	end,
}
