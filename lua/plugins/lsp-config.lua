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
      automatic_enable = {
        exclude = { "ts_ls" },
      },
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
      local use_tsc = vim.g.use_tsc == true
      local typescript_server = use_tsc and 'tsc' or 'ts_ls'

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
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
              -- Don't set library here: lazydev manages that for you
            },
            telemetry = {
              enable = false,
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

      vim.lsp.config('tsc', {
        cmd = {
          vim.fn.stdpath('data') .. '/tools/tsc/node_modules/.bin/tsc',
          '--lsp',
          '--stdio',
        },
      })

      -- MDX language server for JSX intellisense in .mdx files
      vim.lsp.config('mdx_analyzer', {
        cmd = { 'mdx-language-server', '--stdio' },
        filetypes = { 'mdx' },
        root_markers = { 'package.json', '.git' },
        init_options = {
          typescript = {},
        },
        on_attach = function(client, bufnr)
          -- mdx_analyzer doesn't provide its own completions/diagnostics,
          -- it delegates to the active TypeScript server.
          local clients = vim.lsp.get_clients({ name = typescript_server })
          if #clients > 0 then
            vim.lsp.buf_attach_client(bufnr, clients[1].id)
          end
        end,
      })

      -- Configure CSS Variables server with custom lookup files
      vim.lsp.config('css_variables', {
        cmd = { 'css-variables-language-server', '--stdio' },
        init_options = {
          lookupFiles = {
            "src/**/*.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/font.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/text.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/motion.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/space.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/size.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/colors.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/sbrand/colors.css",
            "/src/app/(frontend)/mediaQueries.css"
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
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/font.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/text.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/motion.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/space.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/size.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/colors.css",
            "node_modules/@s-group/design-system-tokens/dist/web/tokens/sbrand/colors.css",
            "/src/app/(frontend)/mediaQueries.css"
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
      vim.lsp.enable(typescript_server)
      vim.lsp.enable('cssmodules_ls')
      vim.lsp.enable('css_variables')
      vim.lsp.enable('mdx_analyzer')


    end,
  },
}
