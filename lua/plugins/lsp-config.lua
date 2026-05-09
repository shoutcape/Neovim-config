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
      automatic_enable = false,
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters used by conform.nvim
        "stylua",
        "prettierd",
        "prettier",
        "shfmt",
      },
      run_on_start = true,
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
        callback = function(args)
          local buf = args.buf

          local function bmap(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          bmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
          bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        end,
      })

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
      vim.lsp.enable('ts_ls')
      vim.lsp.enable('cssmodules_ls')
      vim.lsp.enable('css_variables')


    end,
  },
}
