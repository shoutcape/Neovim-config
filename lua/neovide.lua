if vim.g.neovide then

  --fonts
	vim.g.gui_font_default_size = 12
	vim.g.gui_font_size = vim.g.gui_font_default_size
	vim.g.gui_font_face = "0xProto Nerd Font"

  --gui
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_cursor_animation_length = 0.100

  --color/transparency
  local tranparency = 0.68
	vim.g.neovide_opacity = 0.83
  vim.g.neovide_background_color = ("#2D2A2E" .. string.format("%x", math.floor(((255 * tranparency) or 0.8))))

	RefreshGuiFont = function()
		vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
	end

	ResizeGuiFont = function(delta)
		vim.g.gui_font_size = vim.g.gui_font_size + delta
		RefreshGuiFont()
	end

	ResetGuiFont = function()
		vim.g.gui_font_size = vim.g.gui_font_default_size
		RefreshGuiFont()
	end

	-- Call function on startup to set default value
	ResetGuiFont()

	vim.api.nvim_create_autocmd("BufLeave", {
		callback = function()
			vim.g.neovide_scroll_animation_length = 0
			vim.g.neovide_cursor_animation_length = 0
		end,
	})
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			vim.fn.timer_start(70, function()
				vim.g.neovide_scroll_animation_length = 0.3
				vim.g.neovide_cursor_animation_length = 0.08
			end)
		end,
	})

	-- Keymaps
	local opts = { noremap = true, silent = true }

	vim.keymap.set({ "n", "i" }, "<D-+>", function()
		ResizeGuiFont(1)
	end, opts)
	vim.keymap.set({ "n", "i" }, "<D-->", function()
		ResizeGuiFont(-1)
	end, opts)
end
