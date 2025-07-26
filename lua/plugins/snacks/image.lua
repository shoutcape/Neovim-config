return {
	"snacks.nvim",
	opts = {
		image = {
			enabled = true,
			backend = "kitty", -- Ghostty tukee Kitty Graphics Protocolia

			formats = {
				"png",
				"jpg",
				"jpeg",
				"gif",
				"bmp",
				"webp",
				"tiff",
				"heic",
				"avif",
				"mp4",
				"mov",
				"avi",
				"mkv",
				"webm",
				"pdf",
			},

			doc = {
				enabled = true,
				inline = false, -- renderöi kuvat suoraan bufferiin
				float = true, -- varakäyttö jos inline ei toimi
				max_width = 80,
				max_height = 40,
				conceal = function(lang, type)
					return type == "math" -- peitä vain matemaattinen renderöinti
				end,
			},

			img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },

			wo = {
				wrap = false,
				number = false,
				relativenumber = false,
				cursorcolumn = false,
				signcolumn = "no",
				foldcolumn = "0",
				list = false,
				spell = false,
				statuscolumn = "",
			},

			convert = {
				notify = true,
				mermaid = function()
					local theme = vim.o.background == "light" and "neutral" or "dark"
					return { "-i", "{src}", "-o", "{file}", "-b", "transparent", "-t", theme, "-s", "{scale}" }
				end,
				magick = {
					default = { "{src}[0]", "-scale", "1920x1080>" },
					vector = { "-density", 192, "{src}[0]" },
					math = { "-density", 192, "{src}[0]", "-trim" },
					svg = { "-density", 192, "{src}", "-background", "none", "-resize", "800x600" },
					pdf = { "-density", 192, "{src}[0]", "-background", "white", "-alpha", "remove", "-trim" },
				},
			},

			math = {
				enabled = true,
				latex = {
					font_size = "Large",
					packages = { "amsmath", "amssymb", "amsfonts", "amscd", "mathtools" },
				},
				typst = {
					tpl = [[
            #set page(width: auto, height: auto, margin: (x: 2pt, y: 2pt))
            #show math.equation.where(block: false): set text(top-edge: "bounds", bottom-edge: "bounds")
            #set text(size: 12pt, fill: rgb("${color}"))
            ${header}
            ${content}
          ]],
				},
			},

			icons = {
				math = "󰪚 ",
				chart = "󰄧 ",
				image = " ",
			},
		},
	},
}
