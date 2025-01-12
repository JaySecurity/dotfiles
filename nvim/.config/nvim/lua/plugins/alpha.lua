return {
 "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    local headers = {
      img = {
        [[                                                    ]],
        [[                                                    ]],
        [[                                                    ]],
        [[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
        [[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
        [[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
        [[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
        [[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
        [[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
        [[                                                    ]],
        [[                                                    ]],
        [[                                                    ]],
      },

      img1 = {
        [[                                              ]],
        [[                                              ]],
        [[     _   __ ______ ____  _    __ ____ __  ___ ]],
        [[    / | / // ____// __ \| |  / //  _//  |/  / ]],
        [[   /  |/ // __/  / / / /| | / / / / / /|_/ /  ]],
        [[  / /|  // /___ / /_/ / | |/ /_/ / / /  / /   ]],
        [[ /_/ |_//_____/ \____/  |___//___//_/  /_/    ]],
        [[                                              ]],
        [[                                              ]],
      },
    }

    dashboard.section.header.val = headers.img1

    dashboard.section.buttons.val = {
      dashboard.button("e", "    New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "    Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "    Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("c", "    Config", ":EditConfig<CR>"),
      dashboard.button("q", "    Quit", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
}
