return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function()
      require("mason").setup({})
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    opts = {
      auto_installer = true,
    },
  },

  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = "VeryLazy",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "html", "tsserver", "cssls" },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")

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
      })

      --typescript/javascript
      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --html
      lspconfig.html.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      --eslint
      -- lspconfig.eslint.setup({
      --      experimental = {
      --        useFlatConfig = true
      -- },
      -- })
    end,
  },
}
