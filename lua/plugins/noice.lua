return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      inc_rename = true,
      lsp_doc_border = true,
    },
    popupmenu = {
      enabled = true,
      backend = "nui",
      kind_icons = {},
    },
    views = {
      cmdline_popup = {
        position = { row = 20, col = "50%" },
        size = { width = 60, height = "auto" },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 23, col = "50%" },
        size = { width = 60, height = 10 },
        border = { style = "rounded", padding = { 0, 1 } },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)

    require("notify").setup({
      background_colour = "#000000",
      render = "minimal",
      minimum_width = 10,
    })

    -- Integrate Noice status into lualine's tabline
    local has_noice, noice_api = pcall(require, "noice.api.statusline.mode")
    if has_noice and require("lualine") then
      local lualine = require("lualine")
      lualine.setup({
        tabline = {
          lualine_x = {
            {
              noice_api.get,
              cond = noice_api.has,
              color = { fg = "#ff9e64" },
            },
          },
        },
      })
    end
  end,
}
