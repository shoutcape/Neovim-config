return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_installer = true,
		},
	},

	{
		"jose-elias-alvarez/nvim-lsp-ts-utils",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "tsserver", "cssls" },
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
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

      lspconfig.cssls.setup({
        capabilities = capabilities
      })
			lspconfig.tsserver.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.html.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
		end,
	},
}
