return {
  "stevearc/conform.nvim",
  opts = function()
    local kotlin_tools = require("kotlin-tools")

    return {
      -- Map filetypes to formatters (run sequentially unless stop_after_first is set)
      formatters_by_ft = {
        lua = { "stylua" },

        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },

        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },

        html = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },

        markdown = { "prettierd", "prettier", stop_after_first = true },
        mdx = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },

        kotlin = { "ktlint" },

        ["*"] = { "trim_whitespace" },
      },

      formatters = {
        ktlint = {
          command = kotlin_tools.executable("ktlint"),
          args = { "--log-level=none", "--format", "--stdin", "--stdin-path", "$FILENAME" },
          stdin = true,
          condition = function()
            return vim.fn.executable(kotlin_tools.executable("ktlint")) == 1
          end,
        },
      },

      -- Better defaults
      default_format_opts = {
        timeout_ms = 3000,
        lsp_format = "fallback",
      },

      notify_on_error = true,
      notify_no_formatters = true,
    }
  end,

  keys = {
    {
      "<leader>gf",
      function()
        vim.lsp.buf.format()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer or selection"
    }
  }
}
