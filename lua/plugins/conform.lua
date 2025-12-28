return
{
  "stevearc/conform.nvim",
  opts = function()
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
        yaml = { "prettierd", "prettier", stop_after_first = true },

        ["*"] = { "trim_whitespace" },
      },

      -- Better defaults
      default_format_opts = {
        timeout_ms = 1000,
        lsp_format = "fallback",
      },

      notify_on_error = true,
      notify_no_formatters = true,
    }
  end,

  vim.keymap.set({ "n", "v" }, "<leader>gf", function(client, bufnr)
    vim.lsp.buf.format()
    require("conform").format({ bufnr })
  end, { desc = "Format buffer or selection" })
}
