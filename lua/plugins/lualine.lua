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


      local colors = {
        pure_white = "#ffffff",    -- White
        vibrant_green = "#00aa46", -- Vibrant green
        light_green = "#32a874",   -- Lighter green
        pale_green = "#e6faee",    -- Very light green background
        soft_green = "#76c4a1",    -- Soft green for insert mode
        medium_green = "#48a379",  -- Medium green for visual mode
        accent_red = "#ff6262",    -- Complementary red for replace mode
        light_gray = "#bbbbbb",    -- Light gray for inactive text
        pale_green_1 = "#a1d2b8",  -- Pale green for inactive backgrounds
        pale_green_2 = "#c9e8d8",  -- Lighter pale green for inactive
        pale_green_3 = "#eafaf3",  -- Very light pale green for inactive
        text_green = "#004628",
        darkest_green = "#185339",
      }

      local mode = {
        "mode",
        fmt = function(str)
          -- Replace the returnable value with' ' or use a custom unicode
          -- displays only the first character of the mode
          return "\u{49000}" .. str
        end,
      }

      local diff = {
        'diff',
        colored = true,
        symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
        -- cond = hide_in_width,
      }

      local filename = {
        'filename',
        file_status = true,
        path = 1,
      }

      vim.api.nvim_set_hl(0, "LualineBuffersActive", { fg = "#ffffff", bg = "#185339", bold = true })
      vim.api.nvim_set_hl(0, "LualineBuffersInactive", { fg = "#004628", bg = "#eafaf3" })

      local branch = { 'branch', icon = { '', color = { fg = colors.accent_red } } }

      local my_lualine_theme = {
        normal = {
          a = { fg = colors.vibrant_green, bg = colors.pure_white },
          b = { fg = colors.pure_white, bg = colors.darkest_green, gui = "bold" },
          c = { fg = colors.text_green, bg = colors.pale_green },
          y = { fg = colors.pure_white, bg = colors.light_green },
          z = { fg = colors.pure_white, bg = colors.darkest_green }
        },
        insert = {
          a = { fg = colors.pure_white, bg = colors.soft_green },
          b = { fg = colors.pure_white, bg = colors.darkest_green, gui = "bold" },
          c = { fg = colors.text_green, bg = colors.pale_green },
          y = { fg = colors.pure_white, bg = colors.light_green },
          z = { fg = colors.pure_white, bg = colors.darkest_green }
        },
        visual = {
          a = { fg = colors.pure_white, bg = colors.medium_green },
          b = { fg = colors.pure_white, bg = colors.darkest_green, gui = "bold" },
          c = { fg = colors.text_green, bg = colors.pale_green },
          y = { fg = colors.pure_white, bg = colors.light_green },
          z = { fg = colors.pure_white, bg = colors.darkest_green }
        },
        replace = {
          a = { fg = colors.pure_white, bg = colors.accent_red },
          b = { fg = colors.pure_white, bg = colors.darkest_green, gui = "bold" },
          c = { fg = colors.text_green, bg = colors.pale_green },
          y = { fg = colors.pure_white, bg = colors.light_green },
          z = { fg = colors.pure_white, bg = colors.darkest_green }
        },
        inactive = {
          a = { fg = colors.light_gray, bg = colors.pale_green_1 },
          b = { fg = colors.light_gray, bg = colors.pale_green_2 },
          c = { fg = colors.text_green, bg = colors.pale_green },
          y = { fg = colors.pure_white, bg = colors.light_green },
          z = { fg = colors.pure_white, bg = colors.darkest_green }
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
          lualine_b = { diff },
          lualine_c = { branch, filename },
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
              max_length = 250,
              symbols = {
                modified = " ",
                alternate_file = "󰮲 ",
                directory = "",
              },
              buffers_color = {
                active = "LualineBuffersActive",
                inactive = "LualineBuffersInactive",
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
