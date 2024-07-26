return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          extra_args = {
            "--single-quote",
            "--jsx-single-quote",
            "--tab-width",
            "2",
            -- "--no-semi",
            "--printWidth",
            "60",
            "--end-of-line",
            "lf",
          },
        }),
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
