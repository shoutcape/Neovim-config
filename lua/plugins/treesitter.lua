local parsers = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"elixir",
	"heex",
	"javascript",
	"typescript",
	"tsx",
	"html",
	"json",
	"kotlin",
	"markdown",
	"markdown_inline",
}

local filetypes = {
	"c",
	"lua",
	"vim",
	"help",
	"query",
	"elixir",
	"heex",
	"javascript",
	"javascriptreact",
	"typescript",
	"typescriptreact",
	"html",
	"json",
	"kotlin",
	"markdown",
}

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(parsers)

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				vim.treesitter.start()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
