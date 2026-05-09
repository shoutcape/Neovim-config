return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		local filetypes = {
			"c",
			"css",
			"elixir",
			"heex",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"lua",
			"markdown",
			"python",
			"scss",
			"typescript",
			"typescriptreact",
			"tsx",
			"vim",
			"vimdoc",
			"yaml",
		}

		vim.api.nvim_create_autocmd("FileType", {
			pattern = filetypes,
			callback = function()
				local ok = pcall(vim.treesitter.start)
				if ok then
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
