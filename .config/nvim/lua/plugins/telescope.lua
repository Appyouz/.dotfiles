local telescope = pcall(require, "telescope")

local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

return {
  { "nvim-telescope/telescope-file-browser.nvim" },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local fb_actions = require("telescope").extensions.file_browser.actions

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
        extensions = {
          file_browser = {
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                ["<C-w>"] = function()
                  vim.cmd("normal vbd")
                end,
              },
              ["n"] = {
                ["N"] = fb_actions.create,
                ["h"] = fb_actions.goto_parent_dir,
                ["/"] = function()
                  vim.cmd("startinsert")
                end,
              },
            },
          },
        },
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
      vim.keymap.set("n", "<leader>e", function()
        require("telescope").load_extension("file_browser")
        require("telescope").extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
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
