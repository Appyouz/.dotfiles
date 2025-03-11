require("user.configs")
require("user.lazy")

vim.api.nvim_command([[
  autocmd BufWritePost * LspRestart
]])

