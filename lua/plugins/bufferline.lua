return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
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

    require("bufferline").setup({
      options = {
        mode = "buffers",
        separator_style = "slant",
        always_show_bufferline = true,
        themable = true,
        indicator = {
          style = "icon",
        },
        modified_icon = " ",
        left_trunc_marker = "",
        right_trunc_marker = "",
        diagnostics = "nvim_lsp",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_duplicate_prefix = false,
        show_close_icon = true,
        enforce_regular_tabs = false,
        max_name_length = 30,
        tab_size = 20,

        -- Exclude special buffers from the bufferline
        custom_filter = function(buf_number)
          -- Exclude special buffer types
          local excluded_ft = {
            "help",
            "qf", -- quickfix
            "fugitive",
            "git",
            "Trouble",
            "copilot",
            "noice",
            "TelescopePrompt",
          }

          local ft = vim.bo[buf_number].filetype
          -- Return true to include buffer, false to exclude
          return not vim.tbl_contains(excluded_ft, ft)
        end,

        pick = {
          alphabet = "abcdefghijklmopqrstuvwxyz",
        },

        -- Add offset for special buffers to maintain main window width
        offsets = {
          {
            filetype = "help",
            text = "Help Documentation",
            highlight = "Directory",
            text_align = "center",
          },
          {
            filetype = "copilot",
            text = "Copilot",
            highlight = "Directory",
            text_align = "center",
          },
          -- Add other special filetypes as needed
        },

      },
      highlights = {
        -- Empty space in the bufferline
        fill = {
          fg = 'NONE',
          bg = colors.light_green,
        },
        -- Regular buffer (not selected)
        background = {
          fg = colors.text_green,
          bg = colors.pure_white,
        },
        -- Currently focused buffer
        buffer_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
          bold = true,
          italic = false,
        },
        -- Buffer in a non-current window
        buffer_visible = {
          fg = colors.text_green,
          bg = colors.pure_white,
        },
        -- The separator between buffer tabs
        separator = {
          fg = colors.medium_green,
          bg = colors.pure_white,
        },
        -- Separator of the selected buffer
        separator_selected = {
          fg = colors.medium_green,
          bg = colors.darkest_green,
        },
        -- Separator of visible but not focused buffer
        separator_visible = {
          fg = colors.light_green,
          bg = colors.pure_white,
        },
        -- Close button of non-selected buffers
        close_button = {
          fg = colors.text_green,
          bg = colors.pure_white,
        },
        -- Close button of the selected buffer
        close_button_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
        },
        -- Close button of visible but not focused buffer
        close_button_visible = {
          fg = colors.darkest_green,
          bg = colors.pure_white,
        },
        -- Buffer indicator for selected buffer
        indicator_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
        },
        -- Modified indicator for non-selected buffers
        modified = {
          fg = colors.accent_red,
          bg = colors.light_green,
        },
        -- Modified indicator for selected buffer
        modified_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
        },
        -- Modified indicator for visible but not focused buffer
        modified_visible = {
          fg = colors.text_green,
          bg = colors.pure_white,
        },
        -- Duplicate filename formatting
        duplicate = {
          fg = colors.darkest_green,
          bg = colors.pure_white,
          italic = true,
        },
        -- Duplicate filename in selected buffer
        duplicate_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
          italic = true,
        },
        -- Error diagnostics indicator
        error = {
          fg = colors.accent_red,
          bg = colors.light_green,
        },
        -- Error diagnostics in selected buffer
        error_selected = {
          fg = colors.accent_red,
          bg = colors.darkest_green,
        },
        -- Warning diagnostics indicator
        warning = {
          fg = "#e6c700",
          bg = colors.pure_white,
        },
        -- Warning diagnostics in selected buffer
        warning_selected = {
          fg = "#e6c700",
          bg = colors.darkest_green,
        },
        -- Info diagnostics indicator
        info = {
          fg = "#00aaff",
          bg = colors.light_green,
        },
        -- Info diagnostics in selected buffer
        info_selected = {
          fg = "#00aaff",
          bg = colors.darkest_green,
        },
        -- Hint diagnostics indicator
        hint = {
          fg = colors.light_green,
          bg = colors.light_green,
        },
        -- Hint diagnostics in selected buffer
        hint_selected = {
          fg = colors.light_green,
          bg = colors.darkest_green,
        },
        -- Tab styling (when using tabs mode)
        tab = {
          fg = colors.text_green,
          bg = colors.pure_white,
        },
        -- Selected tab styling
        tab_selected = {
          fg = colors.pure_white,
          bg = colors.darkest_green,
        },
        -- Close button for tabs
        tab_close = {
          fg = colors.accent_red,
          bg = colors.light_green,
        },
      },
    })
  end,
}
