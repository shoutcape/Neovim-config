return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
		{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
	},
	opts = {
		model = "claude-3.7-sonnet-thought",
		debug = false,
		mappings = {
			close = {
				normal = "q",
				insert = "<C-c>",
			},
			reset = {
				normal = "<C-l>",
				insert = "<C-l>",
			},
		},
		show_help = false,
		window = {
			layout = "vertical", --- 'vertical', 'horizontal', 'float', 'replace'
			width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
			height = 0.5, -- fractional height of parent, or absolute height in rows when > 1
		},
		system_prompt = "You are an expert AI assistant for coding. Always provide well-structured, efficient, and idiomatic solutions with comments explaining the code. If refactoring is needed, suggest improvements clearly.",
		auto_follow_cursor = false,
		auto_format = true,
		temperature = 0.7,
	},
	vim.api.nvim_set_keymap(
		"n",
		"<leader>cp",
    ":<C-u>lua require('CopilotChat').toggle()<CR>",
		{ noremap = true, silent = true }
	),
	vim.api.nvim_set_keymap(
		"v",
		"<leader>cp",
		":<C-u>lua require('CopilotChat').toggle({ selection = require('CopilotChat.select').visual })<CR>",
		{ noremap = true, silent = true }
	),
}
