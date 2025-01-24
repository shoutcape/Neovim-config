return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		local dashboard = require("alpha.themes.startify")

		dashboard.section.header.val = {

			[[                                                          ]],
			[[                                                          ]],
			[[                                                          ]],
			[[    ███    ██ ███████  ██████  ██    ██ ██ ███    ███     ]],
			[[    ████   ██ ██      ██    ██ ██    ██ ██ ████  ████     ]],
			[[    ██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██     ]],
			[[    ██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██     ]],
			[[    ██   ████ ███████  ██████    ████   ██ ██      ██     ]],
		}
    require'alpha'.setup(dashboard.config)
	end,
}
