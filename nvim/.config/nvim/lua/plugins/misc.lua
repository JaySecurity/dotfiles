-- lua/custom/plugins/mini.lua
return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    enabled = true,
    config = function()
      require("mini.surround").setup()
      require("mini.ai").setup()
      require("mini.pairs").setup()
    end,
  },
  -- {    -- autoclose tags
  --   "windwp/nvim-ts-autotag",
  -- },
  {
    -- Powerful Git integration for Vim
    "tpope/vim-fugitive",
  },
  {
    -- Highlight todo, notes, etc in comments
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    -- high-performance color highlighter
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
}
