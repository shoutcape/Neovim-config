return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "cssls",
        "html",
        "jsonls",
        "pyright",
        "tailwindcss",
        "eslint",
        "ts_ls",
      },
      handlers = {
        -- Default handler (applies to every server unless overridden below)
        function(server)
          require("lspconfig")[server].setup({})
        end,

        -- Per-server override(s)
        ts_ls = function()
          require("lspconfig").ts_ls.setup({
            init_options = {
              -- give the TypeScript server more memory
              maxTsServerMemory = 8192, -- try 4096 first if 8GiB is too much
            },
          })
        end,
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- custom diagnostic float UI
      vim.diagnostic.config({
        float = {
          border = {
            { "╭", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╮", "FloatBorder" },
            { "│", "FloatBorder" },
            { "╯", "FloatBorder" },
            { "─", "FloatBorder" },
            { "╰", "FloatBorder" },
            { "│", "FloatBorder" },
          },
          source = "always",
          prefix = function(_, i, total)
            return string.format(" [%d/%d]", i, total)
          end,
        },
      })
      -- no direct server setups here; mason-lspconfig handles those via handlers
    end,
  },
}
