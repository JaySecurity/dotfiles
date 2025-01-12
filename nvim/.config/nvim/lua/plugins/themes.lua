return {
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        transparent = true,
      })
    end,
  },
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
      transparent_background = true,
      gamma = 1.00, -- adjust the brightness of the theme
      styles = {
        comments = { italic = true }, -- style for comments
        keywords = { italic = true }, -- style for keywords
        identifiers = { italic = true }, -- style for identifiers
        functions = {}, -- style for functions
        variables = {}, -- style for variables
      },
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
    end,
  },
  {
    "maxmx03/fluoromachine.nvim",
    lazy = false,
    config = function()
      local fm = require("fluoromachine")

      fm.setup({
        glow = true,
        theme = "fluoromachine",
        transparent = true,
      })
    end,
  },
  {
    "luisiacc/gruvbox-baby",
    -- config = function()
    --   require("gruvbox-baby").setup({
    --     transparent_mode = true,
    --     background_color = "dark",
    --   })
    -- end,
  },
  {
    "sekke276/dark_flat.nvim",
    opts = {
      transparent = true,
      italics = true,
    },
  },
}
