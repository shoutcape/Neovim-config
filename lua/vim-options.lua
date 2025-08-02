-- Set leader early to avoid remap issues
vim.g.mapleader = " "

------------------------------------------------------------------------------
-- EDITOR OPTIONS
------------------------------------------------------------------------------
-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Display
vim.opt.conceallevel = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Behavior
vim.opt.incsearch = true
vim.opt.scrolloff = 20
vim.opt.autoread = true
vim.opt.cursorline = true

------------------------------------------------------------------------------
-- AUTOCOMMANDS
------------------------------------------------------------------------------
-- Auto reload on file changes
local autoread_group = vim.api.nvim_create_augroup("AutoReadCheck", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "InsertEnter", "FocusGained" }, {
	group = autoread_group,
	pattern = "*",
	command = "if mode() != 'c' | checktime | endif",
})

-- Highlight yanked text
local highlight_group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_group,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
	end,
})

------------------------------------------------------------------------------
-- HELPER FUNCTIONS
------------------------------------------------------------------------------
-- Shorthand for setting keymaps
local map = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- Toggle quickfix window
local function toggle_quickfix()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			qf_exists = true
			break
		end
	end

	if qf_exists then
		vim.cmd("cclose")
	else
		vim.cmd("copen")
	end
end

------------------------------------------------------------------------------
-- KEYMAPS
------------------------------------------------------------------------------

-- Disabled default keymaps
map("n", "<C-L>", "<Nop>")
map("n", "<C-.>", "<Nop>")
map("n", "L", "<Nop>")
map("n", "<C-,>", "<Nop>")
map("n", "S", "<Nop>")
map("n", "<C-v>", "<Nop>")
map("n", "<C-G>", "<Nop>")

-- Window Navigation
map("n", "<C-h>", "<C-w>h") -- Move focus to the left window
map("n", "<C-j>", "<C-w>j") -- Move focus to the window below
map("n", "<C-k>", "<C-w>k") -- Move focus to the window above
map("n", "<C-l>", "<C-w>l") -- Move focus to the right window
map("v", "<C-h>", "<C-w>h") -- Same for visual mode
map("v", "<C-j>", "<C-w>j")
map("v", "<C-k>", "<C-w>k")
map("v", "<C-l>", "<C-w>l")

-- Window Resizing
map("n", "<C-Down>", ":resize +6<CR>") -- Increase window height
map("n", "<C-Up>", ":resize -6<CR>") -- Decrease window height
map("n", "<C-Left>", ":vertical resize +6<CR>") -- Increase window width
map("n", "<C-Right>", ":vertical resize -6<CR>") -- Decrease window width

-- Buffer Navigation
map("n", "Å", ":b#<CR>")
map("n", "<C-G>", "<C-]>")

map("n", "Ö", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "Ä", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })
-- map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all to the left" })
-- map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all to the right" })

-- Search
map("n", "*", "*N") -- Search word without moving cursor
map("n", "/", ":noh<CR>/") -- Reset highlight on new search
map("n", "<leader>rn", ":%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>", { silent = false }) -- Find and replace word under cursor
map("v", "<leader>rn", '"zy:%s/<C-r>z/<C-r>z/g<Left><Left>', { silent = false }) -- Find and replace visual selection

-- Scroll and Navigation
map("n", "<PageUp>", "<C-u>")
map("n", "<PageDown>", "<C-d>")
map("n", "<C-G>", "<C-]>") -- Jump to tag

-- Selection
map("n", "vie", "maggVG") -- Select entire file
map("n", "yie", "maggVGy`a") -- Yank entire file
map("n", "ö", "<C-v>") -- Visual block mode

-- Editing
map("v", "J", ":m '>+1<CR>gv=gv") -- Move selected lines down
map("v", "K", ":m '<-2<CR>gv=gv") -- Move selected lines up
map("n", "<leader>u", "mzu'z") -- Undo keeping cursor position
map("n", "<leader>U", "mz<C-r>'z") -- Redo keeping cursor position
map("x", "<leader>p", '"_dP') -- Paste without yanking

-- Clipboard Integration
map("v", "<D-c>", '"*y') -- Copy to system clipboard
map("v", "<C-c>", '"*y') -- Copy to system clipboard "Ghostty"
map("n", "<D-v>", '"*p') -- Paste from system clipboard
map("v", "<D-v>", '"*p') -- Paste from system clipboard in visual mode

-- Backspace Behavior
map("i", "<C-BS>", "<C-W>") -- Control-Backspace in insert mode
map("c", "<C-BS>", "<C-W>", { silent = false }) -- Control-Backspace in command mode

-- Diagnostics
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Show error in float

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>") -- Exit terminal mode
map("n", "ö", "<C-v>")

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function(args)
		local buf = args.buf
		local name = vim.api.nvim_buf_get_name(buf)

		-- If it's LazyGit (or any command with 'lazygit' in the path)
		if name:lower():match("lazygit") then
			-- Let <Esc> behave normally in lazygit terminal
			vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = buf })
		end
	end,
})

-- Quickfix List Navigation
map("n", "<A-Down>", ":cnext<CR>")
map("n", "<A-Up>", ":cprev<CR>")
map("n", "<leader>q", toggle_quickfix) -- Toggle quickfix window

-- Current file/path utils
map("n", "<F18>", ":cd %:h<CR><cmd>echo getcwd()<CR>")
map("n", "<leader>cc", ":let @+ = expand('%:h')<CR>")

-- Run Python in terminal
map("n", "<A-a>", ':TermExec cmd="python %:p" dir=%:h size=10 direction=horizontal<CR>')

-- Obsidian and CopilotChat
map("n", "<leader>cn", ":ObsidianNew<CR>")
map({ "n", "v" }, "<leader>cp", function()
	require("CopilotChat").toggle({ selection = require("CopilotChat.select").visual })
end)
-- Custom PowerShell script launcher (Windows)
map("n", "<leader>sh", ":!powershell C:\\Users\\kauti\\autodevenv.ps1<CR>")

-- Copilot Chat
map(
	"n",
	"<leader>cp",
	":<C-u>lua require('CopilotChat').toggle({selection = require('CopilotChat.select').visual })<CR>"
)
map(
	"v",
	"<leader>cp",
	":<C-u>lua require('CopilotChat').toggle({ selection = require('CopilotChat.select').visual })<CR>"
)

--keymap for neotree toggle
map("n", "<leader>n", ":Neotree toggle filesystem reveal right<CR>")

map("n", "<leader>gf", vim.lsp.buf.format, {})

vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format()
end, { desc = "Format current buffer" })

-- Define user command and keymap to auto-import

-- local function ts_add_missing_imports_and_format()
-- 	-- Run the command to add missing imports
-- 	vim.lsp.buf.code_action()
-- 	-- Format after a short delay to let the imports apply
-- 	vim.defer_fn(function()
-- 		vim.lsp.buf.format({ async = false })
-- 	end, 100)
-- end
--
-- -- Create command :AddImports
-- vim.api.nvim_create_user_command("AddImports", ts_add_missing_imports_and_format, {})
--
-- -- Optional: Add a convenient keymap
-- vim.keymap.set("n", "<Leader>i", ts_add_missing_imports_and_format, { desc = "Add missing imports" })

local function ts_add_missing_imports_and_format()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.addMissingImports.ts" } }

	vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result, ctx, _)
		if err or not result or vim.tbl_isempty(result) then
			vim.notify("No missing imports to add", vim.log.levels.INFO)
			return
		end

		local action = result[1]
		if action.edit or type(action.command) == "table" then
			if action.edit then
				vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
			end
			if type(action.command) == "table" then
				vim.lsp.buf.execute_command(action.command)
			end
		else
			vim.lsp.buf.execute_command(action)
		end

		-- Format after a short delay
		vim.defer_fn(function()
			vim.lsp.buf.format({ async = false })
		end, 100)
	end)
end

vim.api.nvim_create_user_command("AddImports", ts_add_missing_imports_and_format, {})
vim.keymap.set("n", "<Leader>i", ts_add_missing_imports_and_format, { desc = "Add missing imports" })
