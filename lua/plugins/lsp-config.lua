return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
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
      },
    },
  },

  {
    "pmizio/typescript-tools.nvim",
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        tsserver_plugins = {
          "@styled/typescript-styled-plugin",
        },
        tsserver_max_memory = "auto",
        tsserver_format_options = {
          allowIncompleteCompletions = false,
          allowRenameOfImportPath = false,
        },
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeCompletionsForModuleExports = true,
          quotePreference = "auto",
        },
      },
      server = {}
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- local lspconfig = require("lspconfig")

      -- 🌟 Set custom floating window borders globally
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

      -- Set up LSP servers manually
      -- lspconfig.lua_ls.setup({
      --   settings = {
      --     Lua = {
      --       diagnostics = { globals = { "vim" } },
      --       workspace = { checkThirdParty = false },
      --       telemetry = { enable = false },
      --     },
      --   },
      -- })

      -- lspconfig.cssls.setup({
      --   settings = {
      --     css = {
      --       lint = { unknownAtRules = "ignore" },
      --     },
      --   },
      -- })

      -- lspconfig.ts_ls.setup({})
      -- lspconfig.html.setup({})
      -- lspconfig.jsonls.setup({})
      -- lspconfig.pyright.setup({})
      --
      -- lspconfig.tailwindcss.setup({
      --   settings = {
      --     tailwindCSS = {
      --       lint = { unknownAtRules = "ignore" },
      --     },
      --   },
      -- })

      -- lspconfig.eslint.setup({
      --   settings = {
      --     workingDirectory = { mode = "auto" },
      --   },
      -- })
    end,
  },
}
