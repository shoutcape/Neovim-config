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

	-- {
	-- 	"pmizio/typescript-tools.nvim",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	-- 	opts = {
	-- 		settings = {
	-- 			tsserver_format_options = {
	-- 				enable = false,
	-- 			},
	-- 			tsserver_inlay_hints = false,
	-- 			tsserver_diagnostics = false,
	-- 			tsserver_file_preferences = {
	-- 				providePrefixAndSuffixTextForRename = false,
	-- 				provideRefactorNotApplicableReason = false,
	-- 				allowRenameOfImportPath = false,
	-- 			},
	-- 		},
	-- 		on_attach = function(client, bufnr)
	-- 			-- Only enable code actions, disable formatting
	-- 			client.server_capabilities.documentFormattingProvider = false
	-- 			client.server_capabilities.documentRangeFormattingProvider = false
	--
	-- 			-- Keymap for code actions (optional)
	-- 			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP Code Action" })
	-- 		end,
	-- 	},
	-- },

	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

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
			-- 	settings = {
			-- 		workingDirectory = { mode = "auto" },
			-- 	},
			-- })
		end,
	},
}
