return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  config = function()
    vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3B4252" })
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#81A1C1" }) -- Nord blue
    require("ibl").setup({
      indent = {
        char = "│",
        highlight = "IblIndent",
      },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble" },
        buftypes = { "terminal", "nofile" },
      },
    })
  end,
}
