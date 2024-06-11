return {
  {
    "letieu/harpoon-lualine",
    event = "VeryLazy",
    dependencies = {
      {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        branch = "harpoon2",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "dracula",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = true,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { {"filename", path=3} },
          lualine_x = {
              {
                "harpoon2",
                indicators = { "j", "k", "l", "ö" },
                active_indicators = { "[J]", "[K]", "[L]", "[Ö]" },
                _separator = " ",
                no_harpoon = "Harpoon not loaded",
              },
            },
          lualine_y = { "progress" },
          lualine_z = { "filetype" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },

        tabline = {
          lualine_a = {
            {
              "buffers",
              show_filename_only = true,
              max_length = vim.o.columns,
            },
          },
        },

        winbar = {},
        inactive_winbar = {},
        extensions = { "lazy", "mason", "neo-tree", "fugitive", "nvim-dap-ui" },
      })
    end,
  },
}
