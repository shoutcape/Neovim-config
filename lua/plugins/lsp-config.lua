return {
  {
    "mason-org/mason.nvim",
    opts = {
      ui = { border = "rounded" },
    },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = { "ktlint", "stylua", "prettierd" },
      run_on_start = true,
      start_delay = 1000,
      debounce_hours = 24,
    },
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = false,
      ensure_installed = {
        "lua_ls",
        "cssls",
        "html",
        "jsonls",
        "eslint",
        "ts_ls",
        "tsc",
        "mdx_analyzer",
        "cssmodules_ls",
        "css_variables",
        "kotlin_lsp",
      },
    },
  },

  {
<<<<<<< HEAD
=======
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- Formatters used by conform.nvim
        "stylua",
        "prettierd",
        "prettier",
      },
      run_on_start = true,
    },
  },

  {
>>>>>>> 829aa08 (fix: resolve config review findings and restrict comment move restoration)
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/lazydev.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local use_tsc = vim.g.use_tsc == true
      local typescript_server = use_tsc and 'tsc' or 'ts_ls'
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
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
        workspace_required = true,
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

          local repo_root = vim.fs.normalize('~/work/customer-owner-ui')
          local frontend_suffix = '/apps/frontend'
          local root_dir = config.root_dir or ''

          -- The main checkout, plus every worktree layout in use:
          --   <repo>/.worktrees/<name>   (in-repo)
          --   <repo>-worktrees/<name>    (TreeMan CLI)
          --   <repo>.<branch-slug>       (lua/plugins/treeman.lua)
          local function is_frontend_root()
            if root_dir:sub(-#frontend_suffix) ~= frontend_suffix then
              return false
            end
            local checkout = root_dir:sub(1, -#frontend_suffix - 1)
            if checkout == repo_root then
              return true
            end
            for _, prefix in ipairs({ repo_root .. '/.worktrees/', repo_root .. '-worktrees/', repo_root .. '.' }) do
              if checkout:sub(1, #prefix) == prefix and #checkout > #prefix then
                return true
              end
            end
            return false
          end

          if not is_frontend_root() then
            return
          end

          config.settings.options = {
            overrideConfigFile = vim.fn.stdpath('config') .. '/nvim-eslint/customer-owner-ui.config.mjs',
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
