return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = true,     -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split

        inc_rename = true,        -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,    -- add a border to hover docs and signature help
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        backend = "nui", -- backend to use to show regular cmdline completions
        kind_icons = {}, -- set to `false` to disable icons
      },
      views = {
        cmdline_popup = {
          position = {
            row = 20,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 23,
            col = "50%",
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
          win_options = {
            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
          },
        },
      },
    })
    require("notify").setup({
      background_colour = "#000000",
      render = "minimal",
      minimum_width = 10
    })
    vim.api.nvim_set_keymap(
      "n",
      "<Esc>",
      "<cmd>noh<CR><cmd>lua require('notify').dismiss()<CR>",
      { noremap = true, silent = true }
    )

    require("lualine").setup({
      tabline = {
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
          },
        },
      },
    })
  end,
}
