return {
  "catgoose/nvim-colorizer.lua",
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
      },
      display = {
        mode = "background",
      },
    },
  },
}
