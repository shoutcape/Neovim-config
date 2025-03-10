return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = { border = "rounded" },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      opts = {
        auto_installer = true,
      }
    end,
  },

  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {"pyright", "tailwindcss", "lua_ls", "html", "ts_ls", "cssls" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

      local diagnosticBorder = {
        { "󰀦", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "󰀦", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "󰀦", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "󰀦", "FloatBorder" },
        { "▏", "FloatBorder" },
      }

      vim.diagnostic.config({
        float = {
          border = diagnosticBorder,
          source = "always",
          prefix = function(diagnostic, i, total)
            local icon = "" -- You can customize the icon based on severity
            return string.format("%s [%d/%d]", icon, i, total)
          end,
        },
      })

      local on_attach = function(client, bufnr)
        require("nvim-lsp-ts-utils").setup({
          filter_out_diagnostics_by_code = { 80001, 7016 },
        })
        require("nvim-lsp-ts-utils").setup_client(client)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        -- vim.keymap.set("n", "J", vim.diagnostic.open_float())
        vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
      end

      --css styling
      lspconfig.cssls.setup({
        capabilities = capabilities,
        settings = {
          css = {
            lint = {
              unknownAtRules = 'ignore'
            }
          }
        }
      })

      --typescript/javascript
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --html
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --python
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --tailwindcss
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          tailwindCSS = {
            lint = {
              unknownAtRules = 'ignore'
            }
          }
        }
      })

      --lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --eslint
      -- lspconfig.eslint.setup({
      --   workingDirectory = { mode = "auto" },
      -- })
    end,
  },
}
