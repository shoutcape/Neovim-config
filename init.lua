--- Enable Lua loader for better performance
vim.loader.enable(true)

---@type string
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check if lazy.nvim is installed, and clone it if not
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	---@type string
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	---@type string
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })

	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Load core configurations
require("vim-options")
require("neovide")

-- Setup lazy.nvim plugin manager
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	change_detection = {
		notify = false,
	},
	ui = {
		border = "rounded",
	},
})

