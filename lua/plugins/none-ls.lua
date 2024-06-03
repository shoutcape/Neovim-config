return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },


  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        --Define a global eslint config file to have consistent results
        require("none-ls.diagnostics.eslint_d"),
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier.with({
          extra_args = {"--single-quote", "--jsx-single-quote", "--tab-width", "2", "--no-semi", "--printWidth", "60"}
        }),
      },
    })
    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
