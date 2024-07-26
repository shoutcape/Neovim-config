local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
	Copilot = "  ",
}

return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				dependencies = { "rafamadriz/friendly-snippets" },
				config = function()
					local types = require("luasnip.util.types")

					require("luasnip.loaders.from_vscode").lazy_load()

					require("luasnip").setup({
						history = true,
						delete_check_events = "TextChanged",
						-- Display a cursor-like placeholder in unvisited nodes
						-- of the snippet.
						ext_opts = {
							[types.insertNode] = {
								unvisited = {
									virt_text = { { "|", "Conceal" } },
									virt_text_pos = "inline",
								},
							},
						},
					})
				end,
			},

			{
				"Saecki/crates.nvim",
				event = "BufRead Cargo.toml",
				config = true,
			},
      "saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		version = false,
		event = "InsertEnter",
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			-- some shorthands...
			local snip = luasnip.snippet
			local node = luasnip.snippet_node

			--for text placement
			local text = luasnip.text_node

			--for text insertion,
			local i = luasnip.insert_node

			local func = luasnip.function_node
			local choice = luasnip.choice_node
			local dynamicn = luasnip.dynamic_node

			--here you can create your own snippets, see shorthands above.

			--different react language snippets
			local react = {"typescript", "javascriptreact", "javascript", "typescriptreact" }

			for _, language in ipairs(react) do
				luasnip.add_snippets(language, {
					snip("clog", {
						text("console.log("),
						i(1, ""),
						text(")"),
					}),
				})
			end

			--for some reason luasnip does not allow for linechanges inside text()
			-- thats why theres dots on the end to allow for readable formatting

			luasnip.add_snippets("json", {
				snip("lintConfig", {
					text(
						"{"
							.. '"env": {'
							.. '"browser": true,'
							.. '"node": true,'
							.. '"es2021": true'
							.. "},"
							.. '"plugins": ['
							.. '"react"'
							.. "],"
							.. '"extends": ['
							.. '"eslint:recommended",'
							.. '"plugin:react/recommended"'
							.. "],"
							.. '"parserOptions": {'
							.. '"ecmaVersion": 12,'
							.. '"sourceType": "module"'
							.. "},"
							.. '"rules": {'
							.. '"semi": ["error", "never"],'
							.. '"quotes": ["error", "single"],'
							.. '"react/react-in-jsx-scope": "off",'
							.. '"react/prop-types": "off"'
							.. "}"
							.. "}"
					),
				}),
			})

			-- Inside a snippet, use backspace to remove the placeholder.
			vim.keymap.set("s", "<BS>", "<C-O>s", { silent = true })

			cmp.setup({
				-- Disable preselect. On enter, the first thing will be used if nothing
				-- is selected.
				preselect = cmp.PreselectMode.None,
				-- Add icons to the completion menu.
				formatting = {
					format = function(_, vim_item)
						vim_item.kind = cmp_kinds[vim_item.kind] .. vim_item.kind
						return vim_item
					end,
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					-- Make the completion menu bordered.
					completion = cmp.config.window.bordered(),
					-- Disable the documentation popup. It gets too cluttered.
					documentation = cmp.config.disable,
				},

				-- jump to next snippet placeholder
				vim.api.nvim_set_keymap(
					"i",
					"<S-Tab>",
					'<cmd>lua require("luasnip").jump(1)<CR>',
					{ noremap = true, silent = true }
				),
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "crates" },
				},
			})

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

		end,
	},
}
