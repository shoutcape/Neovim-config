return {
  "catgoose/nvim-colorizer.lua",
  event = "VeryLazy",
  config = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "javascript",
        html = { mode = "foreground" },
      },
      user_default_options = {
        RGB      = true,         -- #RGB hex codes
        RRGGBB   = true,         -- #RRGGBB hex codes
        names    = true,         -- "Name" codes like Blue
        RRGGBBAA = true,         -- #RRGGBBAA hex codes
        rgb_fn   = false,        -- CSS rgb() and rgba() functions
        hsl_fn   = false,        -- CSS hsl() and hsla() functions
        css      = false,        -- Enable all CSS features
        css_fn   = false,        -- Enable all CSS functions
        mode     = "background", -- Display mode
      },
    })
  end,
}
