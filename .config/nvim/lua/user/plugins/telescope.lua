local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<C-p>", builtin.find_files, {})

      require("telescope").setup({
        defaults = {
          mappings = {
            n = {
              ["q"] = actions.close,
            },
          },
          initial_mode = "normal",
          theme = "dropdown",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.3,
            },
          },
        },
        extensions = {},
      })

      vim.keymap.set("n", ";f", function()
        builtin.find_files({
          hidden = true,
        })
      end)
      vim.keymap.set("n", ";r", function()
        builtin.live_grep()
      end)
      vim.keymap.set("n", "\\\\", function()
        builtin.buffers()
      end)
      vim.keymap.set("n", ";t", function()
        builtin.help_tags()
      end)
      vim.keymap.set("n", ";;", function()
        builtin.resume()
      end)
      vim.keymap.set("n", ";e", function()
        builtin.diagnostics()
      end)
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
