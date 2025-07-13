return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },

      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },

      json = { { "prettierd", "prettier" } },
      jsonc = { { "prettierd", "prettier" } },

      html = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },

      markdown = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },

      sh = { "shfmt" },
      bash = { "shfmt" },

      -- fallback for unknown filetypes
      ["*"] = { "trim_whitespace" },
    },

    -- Optional: Customize formatter behavior
    formatters = {
      prettierd = {
        prepend_args = { "--no-semi", "--single-quote" }, -- customize to your style
      },
      shfmt = {
        extra_args = { "-i", "2", "-ci" },
      },
    },
  }
}
