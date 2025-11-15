return {
	"snacks.nvim",
	opts = {
		dashboard = {
			preset = {
				keys = {
					{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{
						icon = "󰒲 ",
						key = "L",
						desc = "Lazy",
						action = ":Lazy",
						enabled = package.loaded.lazy ~= nil,
					},
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
				header = [[
  ___       ________      ___    ___ ________  ___   _________    ___    ___ 
 |\  \     |\   __  \    |\  \  /  /|\   __  \|\  \ |\___   ___\ |\  \  /  /|
 \ \  \    \ \  \|\  \   \ \  \/  / | \  \|\  \ \  \\|___ \  \_| \ \  \/  / /
  \ \  \    \ \  \\\  \   \ \    / / \ \   __  \ \  \    \ \  \   \ \    / / 
   \ \  \____\ \  \\\  \   \/  /  /   \ \  \ \  \ \  \____\ \  \   \/  /  /  
    \ \_______\ \_______\__/  / /      \ \__\ \__\ \_______\ \__\__/  / /    
     \|_______|\|_______|\___/ /        \|__|\|__|\|_______|\|__|\___/ /     
                        \|___|/                                 \|___|/      
                                                                           
      ________   _______   ________  ___      ___ ___  _____ ______        
    |\   ___  \|\  ___ \ |\   __  \|\  \    /  /|\  \|\   _ \  _   \      
    \ \  \\ \  \ \   __/|\ \  \|\  \ \  \  /  / | \  \ \  \\\__\ \  \     
     \ \  \\ \  \ \  \_|/_\ \  \\\  \ \  \/  / / \ \  \ \  \\|__| \  \    
      \ \  \\ \  \ \  \_|\ \ \  \\\  \ \    / /   \ \  \ \  \    \ \  \   
       \ \__\\ \__\ \_______\ \_______\ \__/ /     \ \__\ \__\    \ \__\  
        \|__| \|__|\|_______|\|_______|\|__|/       \|__|\|__|     \|__|  
                                                                         ]],
			},

			formats = {
				header = { "%s", hl = "SnacksDashboardHeader", align = "center" },
			},

			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
				{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{ section = "startup" },
				-- {
				-- 	section = "terminal",
				-- 	cmd = "pokemon-colorscripts -r --no-title; sleep .1",
				-- 	random = 1,
				-- 	pane = 3,
				-- 	indent = 2, -- Try this if the plugin supports auto-centering
				-- 	height = 30,
				-- },
			},
		},
	},
	config = function(_, opts)
		-- set highlight group for header
		vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#00aa46" })

		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = "#00aa46" })
			end,
		})

		require("snacks").setup(opts)
	end,
}
