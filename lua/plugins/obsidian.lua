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
				path = "~/Documents/Obsidian",
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

		-- Configure daily notes
		daily_notes = {
			folder = "daily-notes",
			date_format = "%Y-%m-%d-%A",
			alias_format = "%B %-d, %Y",
			default_tags = { "daily-notes" },
			template = nil,
		},

		-- Configure note ID generation
		note_id_func = function(title)
			-- For daily notes, use the date format with day name
			if title ~= nil then
				return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- For regular notes, use timestamp
				return tostring(os.time())
			end
		end,

		-- Configure note frontmatter (new syntax)
		frontmatter = {
			func = function(note)
				local out = { id = note.id, aliases = note.aliases, tags = note.tags }
				if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
					for k, v in pairs(note.metadata) do
						out[k] = v
					end
				end
				return out
			end,
		},
	},

	config = function(_, opts)
		require("obsidian").setup(opts)
	end,
}
