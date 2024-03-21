local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

require("user.options")
require("user.keymaps")
-- require("user.colorschemes")

require('user.lazy')
-- require("lazy").setup("plugins")
vim.cmd.colorscheme "gruvbox-material"
