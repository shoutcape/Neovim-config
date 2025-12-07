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
        "eslint",
        "ts_ls",
        "cssmodules_ls",
        "css_variables",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- custom diagnostic float UI
      --- Configures diagnostic settings for Neovim.
--- @param config table The diagnostic configuration.
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

      -- Configure Lua_Ls
      vim.lsp.config("lua_ls", {
        -- Don't set workspace.library here: lazydev manages that for you 
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              -- So LuaLS stops complaining about `vim`
              globals = { "vim" },
            },
          },
        },
      })

      -- Configure TypeScript server with extra memory
      vim.lsp.config('ts_ls', {
        cmd = { 'typescript-language-server', '--stdio' },
        init_options = {
          maxTsServerMemory = 8192,
        },
      })

      -- Configure CSS Variables server with custom lookup files
      vim.lsp.config('css_variables', {
        cmd = { 'css-variables-language-server', '--stdio' },
        init_options = {
          lookupFiles = {
            "src/**/*.css",
          },
          blacklistFolders = {
            "**/.git",
            "**/.cache",
            "**/build",
          },
        },
        settings = {
          cssVariables = {
            lookupFiles = {
            "src/**/*.css",
            },
            blacklistFolders = {
              "**/.git",
              "**/.cache",
              "**/build",
            },
          }
        },
      })

      vim.lsp.config('eslint', {
        settings = {
          workingDirectory = { mode = 'auto' },
        },
      })

      -- Enable all LSP servers
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('cssls')
      vim.lsp.enable('html')
      vim.lsp.enable('jsonls')
      vim.lsp.enable('eslint')
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('cssmodules_ls')
      vim.lsp.enable('css_variables')


    end,
  },
}
