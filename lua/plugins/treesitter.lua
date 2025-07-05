return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"elixir",
			"heex",
			"javascript",
			"typescript",
			"html",
			"json",
		},
		auto_install = true,
		sync_install = false,

		-- highlight = {
		-- 	enable = true,
		-- 	additional_vim_regex_highlighting = false,
		-- 	disable = function(lang, buf)
		-- 		local max_size = 100 * 1024 -- 100 KB
		-- 		local js_limit = 50 * 1024 -- 50 KB
		-- 		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		-- 		if not ok or not stats then
		-- 			return false
		-- 		end
		-- 		if stats.size > max_size or (lang == "javascript" and stats.size > js_limit) then
		-- 			return true
		-- 		end
		-- 		return false
		-- 	end,
		-- },

		indent = {
			enable = true,
		},

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<CR>",
				node_incremental = "<CR>",
				node_decremental = "<BS>",
				scope_incremental = false,
			},
		},
	},

	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
