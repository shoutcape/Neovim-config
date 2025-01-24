return {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            background = { -- :h background
                light = "latte",
                dark = "mocha",
            },
            transparent_background = true,
            show_end_of_buffer = false,
            term_colors = false,
            dim_inactive = {
                enabled = false,
                shade = "dark",
                percentage = 0.15,
            },
            no_italic = false,
            no_bold = false,
            no_underline = false,
            styles = {
                comments = { "italic" },
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},
                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },
            color_overrides = {},
            custom_highlights = {},
            default_integrations = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {
                    enabled = true,
                    indentscope_color = "",
                },
            },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}

-- return {
-- 	"loctvl842/monokai-pro.nvim",
-- 	lazy = false,
-- 	name = "monokai-pro",
-- 	priority = 1000,
-- 	config = function()
-- 		require("monokai-pro").setup({
-- 			transparent_background = true,
-- 			terminal_colors = true,
-- 			devicons = true, -- highlight the icons of `nvim-web-devicons`
-- 			styles = {
-- 				comment = { italic = true },
-- 				keyword = { italic = true }, -- any other keyword
-- 				type = { italic = true }, -- (preferred) int, long, char, etc
-- 				storageclass = { italic = true }, -- static, register, volatile, etc
-- 				structure = { italic = true }, -- struct, union, enum, etc
-- 				parameter = { italic = true }, -- parameter pass in function
-- 				annotation = { italic = true },
-- 				tag_attribute = { italic = true }, -- attribute of tag in reactjs
-- 			},
-- 			filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
-- 			-- Enable this will disable filter option
-- 			inc_search = "background", -- underline | background
-- 			background_clear = {
-- 				"float_win",
-- 				"toggleterm",
-- 				"telescope",
-- 				"which-key",
-- 				"renamer",
-- 				"notify",
-- 				-- "nvim-tree",
-- 				"neo-tree",
-- 				-- "bufferline", -- better used if background of `neo-tree` or `nvim-tree` is cleared
-- 			}, -- "float_win", "toggleterm", "telescope", "which-key", "renamer", "neo-tree", "nvim-tree", "bufferline"
-- 			plugins = {
-- 				bufferline = {
-- 					underline_selected = false,
-- 					underline_visible = false,
-- 				},
-- 				indent_blankline = {
-- 					context_highlight = "default", -- default | pro
-- 					context_start_underline = false,
-- 				},
-- 			},
--       overridePalette = function(filter)
--       return {
--         dark2 = "#101014",
--         dark1 = "#16161E",
--         background = "#1A1B26",
--         text = "#C0CAF5",
--         accent1 = "#f7768e",
--         accent2 = "#7aa2f7",
--         accent3 = "#e0af68",
--         accent4 = "#9ece6a",
--         accent5 = "#0DB9D7",
--         accent6 = "#9d7cd8",
--         dimmed1 = "#737aa2",
--         dimmed2 = "#787c99",
--         dimmed3 = "#363b54",
--         dimmed4 = "#363b54",
--         dimmed5 = "#16161e",
--       }
--     end
-- 		})
--
-- 		vim.cmd.colorscheme("monokai-pro")
-- 	end,
-- }
