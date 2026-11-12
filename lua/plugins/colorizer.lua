return {
  "catgoose/nvim-colorizer.lua",
<<<<<<< HEAD
  event = "BufReadPre",
  opts = {
    filetypes = {
      "css",
      "javascript",
      html = { mode = "foreground" },
    },
    options = {
      parsers = {
        hex = {
          default = true,  -- covers #RGB and #RRGGBB
          rrggbbaa = true, -- covers #RRGGBBAA
        },
        names = { enable = true },
        rgb = { enable = false },
        hsl = { enable = false },
=======
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "javascript",
        html = { mode = "foreground" },
>>>>>>> 829aa08 (fix: resolve config review findings and restrict comment move restoration)
      },
      display = {
        mode = "background",
      },
    },
  },
}
