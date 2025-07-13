return {
  {
    "letieu/harpoon-lualine",
    event = "VeryLazy",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        event = "VeryLazy",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local lualine = require("lualine")

      local mode = {
        'mode',
        fmt = function(str)
          -- Replace the returnable value with' ' or use a custom unicode
          -- displays only the first character of the mode
          return '\u{49000}' .. str
        end,
      }

      local colors = {
        color0 = "#00aa46",
        color1 = "#ffffff",
        color2 = "#c3ccdc",
        color3 = "#1c1e26",
        color6 = "#a1aab8",
        color7 = "#828697",
        color8 = "#ae81ff",
      }
      local my_lualine_theme = {
        replace = {
          a = { fg = colors.color0, bg = colors.color1 },
          b = { fg = colors.color2, bg = colors.color3 },
        },
        inactive = {
          a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
          b = { fg = colors.color6, bg = colors.color3 },
          c = { fg = colors.color6, bg = colors.color3 },
        },
        normal = {
          a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
          b = { fg = colors.color2, bg = colors.color3 },
          c = { fg = colors.color2, bg = colors.color3 },
        },
        visual = {
          a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
          b = { fg = colors.color2, bg = colors.color3 },
        },
        insert = {
          a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
          b = { fg = colors.color2, bg = colors.color3 },
        },
      }

      lualine.setup({
        options = {
          icons_enabled = true,
          theme = my_lualine_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          refresh = {
            statusline = 100,
            tabline = 100,
            winbar = 100,
          },
        },

        sections = {
          lualine_a = { mode },
          lualine_c = { "filename" },
          lualine_x = {
            {
              "harpoon2",
              indicators = { "h", "j", "k", "l" },
              active_indicators = { "[H]", "[J]", "[K]", "[L]" },
              no_harpoon = "Harpoon not loaded",
              -- optional highlight if using `LualineHarpoonActive`
              -- color = "LualineHarpoonActive",
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "filetype" },
        },


        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              max_length = 150,
              symbols = {
                modified = " ",
                alternate_file = "󰮲 ",
                directory = "",
              },
            },
          },
        },

        winbar = {},
        inactive_winbar = {},
      })
    end,
  },
}
