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
map("n", "<C-Down>", ":resize +6<CR>")           -- Increase window height
map("n", "<C-Up>", ":resize -6<CR>")             -- Decrease window height
map("n", "<C-Left>", ":vertical resize +6<CR>")  -- Increase window width
map("n", "<C-Right>", ":vertical resize -6<CR>") -- Decrease window width

-- Buffer Navigation
map("n", "Å", ":b#<CR>")
map("n", "<C-G>", "<C-]>")


map("n", "Ö", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "Ä", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Close buffer" })
-- map("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close all to the left" })
-- map("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Close all to the right" })

-- Search
map("n", "*", "*N")                                                                   -- Search word without moving cursor
map("n", "/", ":noh<CR>/")                                                            -- Reset highlight on new search
map("n", "<leader>rn", ":%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>", { silent = false }) -- Find and replace word under cursor
map("v", "<leader>rn", '"zy:%s/<C-r>z/<C-r>z/g<Left><Left>', { silent = false })      -- Find and replace visual selection

-- Scroll and Navigation
map("n", "<PageUp>", "<C-u>")
map("n", "<PageDown>", "<C-d>")
map("n", "<C-G>", "<C-]>") -- Jump to tag

-- Selection
map("n", "vie", "maggVG")    -- Select entire file
map("n", "yie", "maggVGy`a") -- Yank entire file
map("n", "ö", "<C-v>")       -- Visual block mode

-- Editing
map("v", "J", ":m '>+1<CR>gv=gv")  -- Move selected lines down
map("v", "K", ":m '<-2<CR>gv=gv")  -- Move selected lines up
map("n", "<leader>u", "mzu'z")     -- Undo keeping cursor position
map("n", "<leader>U", "mz<C-r>'z") -- Redo keeping cursor position
map("x", "<leader>p", '"_dP')      -- Paste without yanking

-- Clipboard Integration
map("v", "<D-c>", '"*y') -- Copy to system clipboard
map("n", "<D-v>", '"*p') -- Paste from system clipboard
map("v", "<D-v>", '"*p') -- Paste from system clipboard in visual mode

-- Backspace Behavior
map("i", "<C-BS>", "<C-W>")                     -- Control-Backspace in insert mode
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
local function add_missing_imports()
  vim.wait(250, function()
    return #vim.diagnostic.get(0) > 0
  end, 10, false)
  local params = vim.lsp.util.make_range_params()
  params.context = { diagnostics = vim.diagnostic.get(0) }

  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
  if not results or vim.tbl_isempty(results) then
    vim.notify("No LSP response", vim.log.levels.WARN)
    return
  end

  for client_id, result in pairs(results) do
    for _, action in ipairs(result.result or {}) do
      local title = action.title:lower()
      if title:find("missing imports") or title:find("add imports") or title:find("import") then
        local client = vim.lsp.get_client_by_id(client_id)

        if action.edit or type(action.command) == "table" then
          -- If it's a codeAction with edits
          vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end

        if action.command then
          vim.lsp.buf.execute_command(action.command)
        end

        vim.notify("✅ Imports added: " .. action.title, vim.log.levels.INFO)
        return
      end
    end
  end

  vim.notify("⚠️ No import actions found", vim.log.levels.WARN)
end


-- Create command :AddImports
vim.api.nvim_create_user_command("AddImports", add_missing_imports, {})

-- Optional: Add a convenient keymap
vim.keymap.set('n', '<Leader>i', add_missing_imports, { desc = 'Add missing imports' })
