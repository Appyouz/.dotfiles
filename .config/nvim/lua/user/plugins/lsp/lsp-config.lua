return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ensure_installed = {
          "clangd",
          "clang-format",
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "clangd" },
      })
    end,
  },
  {
    "j-hui/fidget.nvim", -- Added for LSP status indicators
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local nvim_lsp = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.offsetEncoding = "utf-8"
      local lsp_flags = {
        debounce_text_changes = 150,
      }
      local on_attach = function(client, bufnr)
        -- vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        -- vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- Uncommented
        vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", bufopts)
        vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        -- vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- Uncommented
        vim.keymap.set("n", "<space>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)

        vim.api.nvim_create_autocmd("CursorHold", {
          buffer = bufnr,
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
      end
      require("lspconfig")["pyright"].setup({
        on_attach = on_attach,
        flags = lsp_flags,
        capabilities = capabilities,
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
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
      })
      require("lspconfig")["ts_ls"].setup({
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
      })
      require("lspconfig")["lua_ls"].setup({
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
      })
      require("lspconfig")["clangd"].setup({
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        single_file_support = true,
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        root_dir = nvim_lsp.util.root_pattern(
          ".clangd",
          ".clang-tidy",
          ".clang-format",
          "compile_commands.json",
          "compile_flags.txt",
          "configure.ac",
          ".git"
        ),
        init_options = { fallbackFlags = { "-std=c++2a" } },
      })
      require("lspconfig")["emmet_ls"].setup({
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
      })
      require("lspconfig")["html"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        provideFormatter = true, -- Added for built-in formatting
      })
      require("lspconfig")["marksman"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = { "marksman", "server" },
        filetypes = { "markdown" },
        single_file_support = true,
        flags = lsp_flags,
      })
      require("lspconfig")["cmake"].setup({
        cmd = { "cmake-language-server" },
        filetypes = { "cmake" },
        init_options = { buildDirectory = "build" },
        root_dir = nvim_lsp.util.root_pattern(
          "CMakePresets.json",
          "CTestConfig.cmake",
          ".git",
          "build",
          "cmake"
        ),
        single_file_support = true,
      })
      require("lspconfig")["gopls"].setup({
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = nvim_lsp.util.root_pattern("go.mod", ".git"),
        single_file_support = true,
        on_attach = on_attach,
        capabilities = capabilities,
        flags = lsp_flags,
        settings = { -- Added for better Go analysis
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      })
      local function lsp_highlight_document(client)
        local status_ok, illuminate = pcall(require, "illuminate")
        if not status_ok then
          return
        end
        illuminate.on_attach(client)
      end

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
          vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            update_in_insert = false,
            virtual_text = { spacing = 4, prefix = "●" },
            severity_sort = true,
          })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.diagnostic.config({
        virtual_text = { prefix = "●" },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          source = "always",
          focusable = false,
          style = "minimal",
          border = "rounded",
          header = "",
          prefix = "",
        },
      })
    end,
  },
  {
    "glepnir/lspsaga.nvim",
    config = function()
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
      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
      vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts) -- Added for peek definition
      vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
      vim.keymap.set("n", "<leader>rn", "<Cmd>Lspsaga rename<CR>", opts)

      local codeaction = require("lspsaga.codeaction")
      vim.keymap.set("n", "<leader>ca", function()
        codeaction:code_action()
      end, { silent = true })
      vim.keymap.set("v", "<leader>ca", function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
        codeaction:range_code_action()
      end, { silent = true })
    end,
  },
}

