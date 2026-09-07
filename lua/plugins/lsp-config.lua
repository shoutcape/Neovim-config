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
        "kotlin_lsp",
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
          vim.fn.stdpath('data') .. '/mason/bin/tsc',
          '--lsp',
          '--stdio',
        },
      })

      vim.lsp.config('kotlin_lsp', {
        cmd = {
          vim.fn.stdpath('data') .. '/mason/bin/intellij-server',
          '--stdio',
        },
        root_markers = {
          'settings.gradle',
          'settings.gradle.kts',
          'pom.xml',
          'build.gradle',
          'build.gradle.kts',
          'workspace.json',
        },
        single_file_support = false,
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

      local eslint_before_init = vim.lsp.config.eslint.before_init

      vim.lsp.config('eslint', {
        settings = {
          workingDirectory = { mode = 'auto' },
        },
        before_init = function(params, config)
          eslint_before_init(params, config)

          local repo_root = '/Users/ville.kautiainen/work/customer-owner-ui'
          local frontend_root = repo_root .. '/apps/frontend'
          local worktree_prefix = repo_root .. '/.worktrees/'
          local root_dir = config.root_dir
          local is_worktree_frontend = root_dir:sub(1, #worktree_prefix) == worktree_prefix
            and root_dir:sub(-#'/apps/frontend') == '/apps/frontend'

          if root_dir ~= frontend_root and not is_worktree_frontend then
            return
          end

          config.settings.options = {
            overrideConfigFile = vim.fn.expand('~/.config/nvim/nvim-eslint/customer-owner-ui.config.mjs'),
          }
        end,
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
      vim.lsp.enable('kotlin_lsp')
      vim.lsp.enable('mdx_analyzer')


    end,
  },
}
