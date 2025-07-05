return {
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "dracula",
					component_separators = { left = "", right = "" },
					section_separators = { left = "", right = "" },
					globalstatus = true,
					disabled_filetypes = {
						statusline = {},
						winbar = {},
					},
					refresh = {
						statusline = 100,
						tabline = 100,
						winbar = 100,
					},
				},

				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch", "diff", "diagnostics" },
					lualine_c = { { "filename", path = 3 } },
					lualine_x = {},
					lualine_y = { "progress" },
					lualine_z = { "filetype" },
				},

				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { { "filename", path = 1 } },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},

				tabline = {
					lualine_a = {
						{
							"buffers",
							show_filename_only = true,
							max_length = 150,
							symbols = {
								modified = " ",
								alternate_file = "󰮲 ",
								directory = "",
							},
						},
					},
				},

				winbar = {},
				inactive_winbar = {},

				extensions = { "lazy", "mason", "neo-tree", "fugitive", "nvim-dap-ui" },
			})
		end,
	},
}
