return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.completion.spell,
        -- null_ls.builtins.diagnostics.flake8,
        -- null_ls.builtins.diagnostics.eslint,
      },
    })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, {})
  end,
}
