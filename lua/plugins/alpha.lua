return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local dashboard = require("alpha.themes.startify")

    local header_part1 = {
      [[ ________   _______   ________  ___      ___ ___  _____ ______            ]],
      [[|\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \          ]],
      [[\ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \         ]],
      [[ \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \        ]],
      [[  \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \       ]],
      [[   \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\      ]],
      [[    \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|      ]],
      [[                                                          ]],
    }

    local function set_alpha_highlights()
      vim.api.nvim_set_hl(0, "AlphaHeader1", { fg = "#00aa46" })
    end

    set_alpha_highlights()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = set_alpha_highlights,
    })

    dashboard.section.header_part1 = {
      type = "text",
      val = header_part1,
      opts = { hl = "AlphaHeader1" },
    }

    dashboard.section.header.val = {}

    dashboard.config.layout = {
      { type = "padding", val = 1 },
      dashboard.section.header_part1,
      { type = "padding", val = 2 },
      dashboard.section.top_buttons,
      dashboard.section.mru,
      dashboard.section.bottom_buttons,
      dashboard.section.footer,
    }

    require("alpha").setup(dashboard.config)
  end,
}
