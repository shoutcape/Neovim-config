return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		-- Parsers to keep installed. install() is async and skips ones already present.
		require("nvim-treesitter").install({
			"bash", "c", "css", "diff", "elixir", "go", "gomod", "heex", "html",
			"javascript", "jsdoc", "json", "lua", "luadoc", "markdown", "markdown_inline",
			"printf", "python", "query", "regex", "scss", "toml", "tsx", "typescript",
			"vim", "vimdoc", "xml", "yaml",
		})

		local filetypes = {
			"c",
			"css",
			"elixir",
			"go",
			"gomod",
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
