-- Set leader early to avoid remap issues
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.scrolloff = 20                             -- Keep 10 lines above/below cursor 

-- Indentation
vim.opt.tabstop = 2                                -- Tab width
vim.opt.shiftwidth = 2                             -- Indent width
vim.opt.softtabstop = 2                            -- Soft tab stop
vim.opt.expandtab = true                           -- Use spaces instead of tabs
vim.opt.smartindent = true                         -- Smart auto-indenting
vim.opt.autoindent = true                          -- Copy indent from current line

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = true                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type

-- Visual settings
vim.opt.termguicolors = true                       -- Enable 24-bit colors
vim.opt.signcolumn = "yes"                         -- Always show sign column
vim.opt.showmatch = true                           -- Highlight matching brackets
vim.opt.matchtime = 2                              -- How long to show matching bracket
vim.opt.completeopt = "menuone,noinsert,noselect"  -- Completion options 
vim.opt.conceallevel = 0                           -- Don't hide markup, show all text as is
vim.opt.concealcursor = ""                         -- Don't hide cursor line markup 
vim.opt.synmaxcol = 300                            -- Syntax highlighting limit 


-- File handling
vim.opt.backup = false                             -- Don't create backup files
vim.opt.writebackup = false                        -- Don't create backup before writing
vim.opt.swapfile = false                           -- Don't create swap files
vim.opt.updatetime = 300                           -- Faster completion
vim.opt.timeoutlen = 500                           -- Key timeout duration
vim.opt.ttimeoutlen = 0                            -- Key code timeout
vim.opt.autoread = true                            -- Auto reload files changed outside vim
vim.opt.autowrite = false                          -- Don't auto save

-- Behavior settings
vim.opt.backspace = "indent,eol,start"             -- Better backspace behavior
vim.opt.iskeyword:append("-")                      -- Treat dash as part of word
vim.opt.mouse = "a"                                -- Enable mouse support

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

-- Shorthand
local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { noremap = true, silent = true }, opts or {}))
end

-- Clear unwanted keymaps
local nops = { "<C-L>", "<C-.>", "L", "<C-,>", "S", "<C-v>" }
for _, lhs in ipairs(nops) do
  map("n", lhs, "<Nop>")
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

-- Quickfix List Navigation
map("n", "<A-Down>", ":cnext<CR>")
map("n", "<A-Up>", ":cprev<CR>")
map("n", "<leader>q", toggle_quickfix, { desc = "Toggle QfList" })

-- Navigation between windows
for _, mode in ipairs({ "n", "v" }) do
  map(mode, "<A-h>", "<C-w>h", { desc = "Move to left window" })
  map(mode, "<A-j>", "<C-w>j", { desc = "Move to window below" })
  map(mode, "<A-k>", "<C-w>k", { desc = "Move to window above" })
  map(mode, "<A-l>", "<C-w>l", { desc = "Move to right window" })

  -- Move windows (splits) around with Shift + Ctrl
  map(mode, "<A-S-h>", "<C-w>H", { desc = "Move window to the far left" })
  map(mode, "<A-S-j>", "<C-w>J", { desc = "Move window to the bottom" })
  map(mode, "<A-S-k>", "<C-w>K", { desc = "Move window to the top" })
  map(mode, "<A-S-l>", "<C-w>L", { desc = "Move window to the far right" })
end

-- Better search behavior
map("n", "*", "*N", { desc = "Search word under cursor and go to previous match" })
map("n", "/", ":noh<CR>/", { desc = "Clear highlights and start search" })

-- Buffers and tags
map("n", "Å", ":b#<CR>", { desc = "Switch to previously edited buffer" })
map("n", "<C-G>", "<C-]>", { desc = "Go to tag definition" })

map("n", "Ö", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "Ä", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Select buffer" })

-- Visual selection tweaks
map("n", "vie", "maggVG", { desc = "Select entire file content" })
map("n", "yie", "maggVGy`a", { desc = "Copy entire file content" })
map("x", "<leader>p", '"_dP', { desc = "Paste without overwriting register" })
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Misc movement
map("n", "<PageUp>", "<C-u>", { desc = "Page up (half screen)" })
map("n", "<PageDown>", "<C-d>", { desc = "Page down (half screen)" })
map("n", "ö", "<C-v>", { desc = "Enter visual block mode" })

-- Terminal and diagnostics
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open Diagnostic Float" })

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

-- Clipboard mappings
map("v", "<C-c>", '"*y')
map("n", "<C-v>", '"*p')
map("v", "<C-v>", '"*p')

-- Insert mode enhancements
map("i", "<C-BS>", "<C-W>")

-- Current file/path utils
map("n", "<F18>", ":cd %:h<CR><cmd>echo getcwd()<CR>")
map("n", "<leader>cc", ":let @+ = expand('%:h')<CR>")

-- Run Python in terminal
map("n", "<A-a>", ':TermExec cmd="python %:p" dir=%:h size=10 direction=horizontal<CR>')


-- Obsidian and CopilotChat
map("n", "<leader>cn", ":ObsidianNew<CR>")
map({ "n", "v" }, "<leader>cp", function()
  require("CopilotChat").toggle({ selection = require("CopilotChat.select").visual })
end, { desc = "Toggle CopilotChat" })
-- Custom PowerShell script launcher (Windows)
map("n", "<leader>sh", ":!powershell C:\\Users\\kauti\\autodevenv.ps1<CR>")

map(
  "n",
  "<leader>n",
  ":Neotree toggle filesystem reveal right<CR>",
  { noremap = true, silent = true, desc = "Toggle NeoTree" }
)

map("n", "<leader>rn", ":%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>",
  { desc = "Find and replace word under cursor", silent =  false })
map("v", "<leader>rn", '"zy:%s/<C-r>z/<C-r>z/g<Left><Left>',
  { desc = "Find and replace visual selection", silent = false })

map("n", "<Esc>", "<cmd>noh<CR><cmd>lua require('notify').dismiss()<CR>", { noremap = true, silent = true })

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
