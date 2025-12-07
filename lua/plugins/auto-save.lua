return {
	"Pocco81/auto-save.nvim",
	event = "VeryLazy",
	config = function()
		require("auto-save").setup({
			enabled = true,
			execution_message = {
				message = function()
					return ""
				end,
			},
			trigger_events = { "TextChanged" },
			condition = function(buf)
				-- First check if the buffer ID is valid
				if not vim.api.nvim_buf_is_valid(buf) then
					return false
				end


				-- Don't save in command-line window (q:)
				if vim.bo[buf].buftype == "command" then
					return false
				end

				local utils = require("auto-save.utils.data")
				local ft = vim.bo[buf].filetype
			end,
			write_all_buffers = false,
			debounce_delay = 250,
		})
	end,
}
