-- LSP Configuration for Neovim

-- Ensure the Lua Language Server is installed
-- You can install it via Mason.nvim or your system's package manager

local lspconfig = require("lspconfig")

-- Configure Lua Language Server (sumneko_lua)
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using
				version = "LuaJIT",
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false, -- Disable third-party library checks
			},
			telemetry = {
				enable = false, -- Disable telemetry for privacy
			},
		},
	},
})
