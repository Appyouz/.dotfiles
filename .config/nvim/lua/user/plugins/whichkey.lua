return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  key_labels = {},
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "left",
  },
  ignore_missing = true,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  triggers = "auto",
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },

  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    mode = "n",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true, -- refer to the configuration section below
    spec = {
      { "<leader>a",  "<cmd>Alpha<cr>",                                 desc = "Alpha" },
      { "<leader>b",  "<cmd>Telescope buffers<cr>",                     desc = "Buffers" },
      { "<leader>e",  "<cmd>NvimTreeToggle<CR>",                        desc = "File Browser" },
      { "<leader>P",  "<cmd>Telescope projects<cr>",                    desc = "Projects" },

      { "<leader>g",  group = "Git" },
      { "<leader>gj", ':lua require("gitsigns").next_hunk()<CR>',       desc = "Next Hunk" },
      { "<leader>gk", ':lua require("gitsigns").prev_hunk()<CR>',       desc = "Prev Hunk" },
      { "<leader>gl", ':lua require("gitsigns").blame_line()<CR>',      desc = "Blame" },
      { "<leader>gp", ':lua require("gitsigns").preview_hunk()<CR>',    desc = "Preview Hunk" },
      { "<leader>gr", ':lua require("gitsigns").reset_hunk()<CR>',      desc = "Reset Hunk" },
      { "<leader>gR", ':lua require("gitsigns").reset_buffer()<CR>',    desc = "Reset Buffer" },
      { "<leader>gs", ':lua require("gitsigns").stage_hunk()<CR>',      desc = "Stage Hunk" },
      { "<leader>gu", ':lua require("gitsigns").undo_stage_hunk()<CR>', desc = "Undo Stage Hunk" },
      { "<leader>go", ":Telescope git_status<CR>",                      desc = "Open Changed File" },
      { "<leader>gb", ":Telescope git_branches<CR>",                    desc = "Checkout Branch" },
      { "<leader>gc", ":Telescope git_commits<CR>",                     desc = "Checkout Commit" },

      { "<leader>s",  group = "Search" },
      { "<leader>sc", ":Telescope colorscheme<CR>",                     desc = "Colorscheme" },
      { "<leader>sh", ":Telescope help_tags<CR>",                       desc = "Find Help" },
      { "<leader>sM", ":Telescope man_pages<CR>",                       desc = "Man Pages" },
      { "<leader>sr", ":Telescope oldfiles<CR>",                        desc = "Open Recent File" },
      { "<leader>sR", ":Telescope registers<CR>",                       desc = "Registers" },
      { "<leader>sk", ":Telescope keymaps<CR>",                         desc = "Keymaps" },
      { "<leader>sC", ":Telescope commands<CR>",                        desc = "Commands" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
