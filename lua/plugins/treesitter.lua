return {
  "nvim-treesitter/nvim-treesitter",
  event = 'VeryLazy',
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "html",
        "json",
        "typescript",
      },
      autoinstall = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
