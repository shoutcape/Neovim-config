return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- Use latest release, remove to use latest commit
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp", -- Optional completion integration
		"nvim-treesitter/nvim-treesitter", -- Optional syntax highlighting
		"snacks.nvim", -- Optional picker and image support
	},

	keys = {
		-- Top level commands
		{ "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note"},
		{ "<leader>oo", "<cmd>Obsidian open<cr>", desc = "Open in Obsidian app"},
		{ "<leader>og", "<cmd>Obsidian search<cr>", desc = "Search notes"},
		{ "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch"},
		{ "<leader>oy", "<cmd>Obsidian yesterday<cr>", desc = "Yesterday's note"},
		{ "<leader>od", "<cmd>Obsidian today<cr>", desc = "Today's note"},
		{ "<leader>om", "<cmd>Obsidian tomorrow<cr>", desc = "Tomorrow's note"},
		{ "<leader>ow", "<cmd>Obsidian workspace<cr>", desc = "Switch workspace"},
		{ "<leader>oD", "<cmd>Obsidian dailies<cr>", desc = "List daily notes"},
		{ "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Search tags"},
		{ "<leader>oh", "<cmd>Obsidian help<cr>", desc = "Help wiki"},
		{ "<leader>oH", "<cmd>Obsidian helpgrep<cr>", desc = "Grep help wiki"},
		
		-- Note commands
		{ "gf", "<cmd>Obsidian follow_link<cr>", desc = "Follow link"},
		{ "<leader>ol", "<cmd>Obsidian links<cr>", desc = "List links"},
		{ "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show backlinks"},
		{ "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename note"},
		{ "<leader>oi", "<cmd>Obsidian paste_img<cr>", desc = "Paste image"},
		{ "<leader>oT", "<cmd>Obsidian template<cr>", desc = "Insert template"},
		{ "<leader>oc", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox"},
		{ "<leader>o.", "<cmd>Obsidian toc<cr>", desc = "Table of contents"},
		
		-- Visual mode commands
		{ "<leader>oe", "<cmd>Obsidian extract_note<cr>", desc = "Extract note", mode = "v"},
		{ "<leader>ol", "<cmd>Obsidian link<cr>", desc = "Link to note", mode = "v"},
		{ "<leader>oL", "<cmd>Obsidian link_new<cr>", desc = "Link to new note", mode = "v"},
	},
	---@module 'obsidian'
	---@type obsidian.config
	opts = {
    legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Muistiinpanot",
			},
		},

		-- Use snacks.picker for file picking
		picker = {
			name = "snacks.pick",
		},

		-- Enable completion of wiki links, tags, etc.
		completion = {
			nvim_cmp = true,
			min_chars = 2,
		},

		-- Configure checkboxes order
		checkbox = {
			order = { " ", "x", ">", "~" },
		},

		-- Configure UI with icons
		ui = {
			enable = true,
			bullets = { char = "•", hl_group = "ObsidianBullet" },
			external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
			reference_text = { hl_group = "ObsidianRefText" },
			highlight_text = { hl_group = "ObsidianHighlightText" },
			tags = { hl_group = "ObsidianTag" },
		},
	},

	config = function(_, opts)
		require("obsidian").setup(opts)

		-- Set conceallevel for markdown files to enable Obsidian UI features
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				vim.opt_local.conceallevel = 2
			end,
		})
	end,
}
