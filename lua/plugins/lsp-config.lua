return {
  -- Mason: LSP server installer UI
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },

  -- Bridge mason <-> lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },

  -- TypeScript Tools for faster performance in large projects
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
    config = function()
      -- Set up typescript-tools.nvim
      require("typescript-tools").setup({
        server = {
          on_attach = function(client, bufnr)
            if client.name == "ts_ls" then
              client.server_capabilities.documentFormattingProvider = false
            end
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP Hover" })
            vim.keymap.set(
              "n",
              "<leader>ca",
              vim.lsp.buf.code_action,
              { buffer = bufnr, desc = "LSP Code Action" }
            )
          end,
        },
        settings = {
          tsserver_plugins = {
            "@styled/typescript-styled-plugin", -- Optional: for styled-components support
          },
          tsserver_max_memory = "auto",   -- Auto-adjust memory for tsserver
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeCompletionsForModuleExports = true,
            quotePreference = "auto", -- Choose between single/double quotes
          },
        },
      })
    end,
  },

  -- Core LSP config for other servers (non-TS servers)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic settings (same as before)
      vim.diagnostic.config({
        float = {
          border = {
            { "󰀦", "FloatBorder" },
            { "▔", "FloatBorder" },
            { "󰀦", "FloatBorder" },
            { "▕", "FloatBorder" },
            { "󰀦", "FloatBorder" },
            { "▁", "FloatBorder" },
            { "󰀦", "FloatBorder" },
            { "▏", "FloatBorder" },
          },
          source = "always",
          prefix = function(_, i, total)
            return string.format(" [%d/%d]", i, total)
          end,
        },
      })

      -- General `on_attach` function
      local on_attach = function(_client, bufnr)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
      end

      -- Server setup for other languages (CSS, HTML, Python, etc.)
      local servers = {
        cssls = {
          settings = {
            css = {
              lint = { unknownAtRules = "ignore" },
            },
          },
        },
        html = {},
        pyright = {},
        tailwindcss = {
          settings = {
            tailwindCSS = {
              lint = { unknownAtRules = "ignore" },
            },
          },
        },
        lua_ls = {},
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
          },
        },
      }

      -- Loop over servers and apply configurations
      for server, config in pairs(servers) do
        lspconfig[server].setup(vim.tbl_deep_extend("force", {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config))
      end
    end,
  },
}
