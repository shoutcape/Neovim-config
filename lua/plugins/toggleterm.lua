return {
	"akinsho/toggleterm.nvim",
  event = 'VeryLazy',
	config = function()
        require("toggleterm").setup({
            open_mapping = [[ä]],
            size = 20, -- Terminaalin koko
            hide_numbers = true, -- Piilottaa rivinumerot terminaalibufferissa
            start_in_insert = true, -- Aloittaa insert-tilassa
            insert_mappings = false, -- Mahdollistaa insert-tilassa näppäinkomennot
            terminal_mappings = true, -- Mahdollistaa terminal-tilassa näppäinkomennot
            persist_size = true, -- Säilyttää terminaalin koon
            direction = "horizontal", -- Avaa terminaalin vaakasuunnassa, vaihtoehdot: 'vertical' | 'horizontal' | 'tab' | 'float'
            close_on_exit = true, -- Sulkee terminaalin kun prosessi päättyy
            shell = "pwsh.exe --noLogo", -- Määrittää käytettävän shellin
            float_opts = {
                border = "curved", -- Määrittää kelluvan terminaalin reunustyylin, vaihtoehdot: 'single' | 'double' | 'shadow' | 'curved'
                winblend = 3,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
            },
        })
	end,
}
