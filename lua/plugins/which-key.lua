return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
        local mappings = {
        }
        local wk = require("which-key")
        vim.o.timeout = true
        vim.o.timeoutlen = 300
        wk.register(mappings, opts)
    end,
}
