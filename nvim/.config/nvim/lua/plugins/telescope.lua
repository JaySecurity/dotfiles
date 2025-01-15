return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "andrew-george/telescope-themes" },
      { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      local editConfig = function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config"),
        })
      end
      vim.api.nvim_create_user_command("EditConfig", editConfig, {})
      require("telescope").setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-l>"] = actions.select_default, -- open file
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },
        pickers = {
          find_files = {
            -- theme = "ivy",
            file_ignore_patterns = { "node_modules", ".git", ".venv" },
            hidden = true,
            follow = true,
            previewer = true,
          },
          buffers = {
            initial_mode = "normal",
            sort_lastused = true,
            -- sort_mru = true,
            mappings = {
              n = {
                ["d"] = actions.delete_buffer,
                ["l"] = actions.select_default,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })

      require("telescope").load_extension("fzf")
      pcall(require("telescope").load_extension, "themes")
      pcall(require("telescope").load_extension, "ui-select")

      vim.keymap.set("n", "<space>sh", builtin.help_tags, { desc = "[S]earch  [H]elp" })
      vim.keymap.set("n", "<space>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      vim.keymap.set("n", "<space>en", editConfig, { desc = "[E]dit [N]eovim" })

      vim.keymap.set(
        "n",
        "<leader>lt",
        ":Telescope themes<CR>",
        { noremap = true, silent = true, desc = "[L]aunch [T]heme Picker" }
      )
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<space>ep", function()
        builtin.find_files({
          cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy"),
        })
      end)

      require("config.telescope.multigrep").setup()
    end,
  },
}
