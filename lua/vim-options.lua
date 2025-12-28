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
vim.opt.mouse = "a"                                -- Enable mouse support

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
map("n", "<C-a>", "<Nop>")
map("n", "<C-e>", "<Nop>")
map("v", "<C-a>", "<Nop>")
map("v", "<C-e>", "<Nop>")
map("n", "<C-.>", "<Nop>")
map("n", "L", "<Nop>")
map("n", "<C-,>", "<Nop>")
map("n", "S", "<Nop>")
map("n", "<C-v>", "<Nop>")
map("n", "<C-G>", "<Nop>")
map("n", "<C-Tab>", ":tabnext<CR>", { desc = "next tab" })


-- Navigation between windows
for _, mode in ipairs({ "n", "v" }) do
  map(mode, "<C-h>", "<C-w>h", { desc = "Move to left window" })
  map(mode, "<C-j>", "<C-w>j", { desc = "Move to window below" })
  map(mode, "<C-k>", "<C-w>k", { desc = "Move to window above" })
  map(mode, "<C-l>", "<C-w>l", { desc = "Move to right window" })

  -- Move windows (splits) around with Shift + Ctrl
  map(mode, "<C-S-h>", "<C-w>H", { desc = "Move window to the far left" })
  map(mode, "<C-S-j>", "<C-w>J", { desc = "Move window to the bottom" })
  map(mode, "<C-S-k>", "<C-w>K", { desc = "Move window to the top" })
  map(mode, "<C-S-l>", "<C-w>L", { desc = "Move window to the far right" })
end


-- Default movements
map("n", "<C-a>", "^") -- start of line (first non-blank)
map("n", "<C-e>", "$") -- end of line
map("v", "<C-a>", "^") -- start of line (first non-blank)
map("v", "<C-e>", "$") -- end of line
map("o", "<C-a>", "^") -- operator-pending: start of line
map("o", "<C-e>", "$") -- operator-pending: end of line

-- Window Resizing
map("n", "<D-Down>", ":resize +6<CR>")           -- Increase window height
map("n", "<D-Up>", ":resize -6<CR>")             -- Decrease window height
map("n", "<D-Left>", ":vertical resize +6<CR>")  -- Increase window width
map("n", "<D-Right>", ":vertical resize -6<CR>") -- Decrease window width

-- Buffer Navigation
map("n", "Å", ":b#<CR>")
map("n", "<C-G>", "<C-]>")

map("n", "Ö", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
map("n", "Ä", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer" })

-- Search
map("n", "*", "*N")                                                                   -- Search word without moving cursor
map("n", "/", ":noh<CR>/")                                                            -- Reset highlight on new search
map("n", "<leader>rn", ":%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>", { silent = false }) -- Find and replace word under cursor
map("v", "<leader>rn", '"zy:%s/<C-r>z/<C-r>z/g<Left><Left>', { silent = false })      -- Find and replace visual selection

-- Scroll and Navigation
map("n", "<PageUp>", "<C-u>")
map("n", "<PageDown>", "<C-d>")

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
map("v", "<C-c>", '"*y') -- Copy to system clipboard "Ghostty"
map("n", "<D-v>", '"*p') -- Paste from system clipboard
map("v", "<D-v>", '"*p') -- Paste from system clipboard in visual mode

-- Backspace Behavior
map("i", "<C-BS>", "<C-W>")                     -- Control-Backspace in insert mode
map("c", "<C-BS>", "<C-W>", { silent = false }) -- Control-Backspace in command mode

-- Diagnostics
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>") -- Show error in float

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>") -- Exit terminal mode

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

-- CopilotChat
map({ "n", "v" }, "<leader>cp", function()
  require("CopilotChat").toggle()
end, { desc = "Toggle CopilotChat" })

vim.api.nvim_create_user_command("Format", function()
  vim.lsp.buf.format()
end, { desc = "Format current buffer" })


--function for adding missing imports in ts
local function ts_add_missing_imports_and_format(opts)
  opts = opts or {}
  local range_params = vim.lsp.util.make_range_params(0, "utf-8")

  local params = {
    textDocument = range_params.textDocument,
    range = range_params.range,
    context = { only = { "source.addMissingImports.ts" }, diagnostics = {} }
  }

  params.context = { only = { "source.addMissingImports.ts" }, diagnostics = {} }

  vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, result)
    if err or not result or vim.tbl_isempty(result) then
      -- Silence when called with a bang (e.g., :cdo AddImports!)
      if not opts.bang then
        -- Also dedupe in case you trigger it repeatedly in one session
        vim.notify_once("No missing imports to add", vim.log.levels.INFO)
      end
      return
    end

    local action = result[1]
    if action.edit or type(action.command) == "table" then
      if action.edit then
        vim.lsp.util.apply_workspace_edit(action.edit, "utf-8")
      end
      if type(action.command) == "table" then
        vim.lsp.buf_request_sync(0, "workspace/executeCommand", action.command, 1000)
      end
    else
      vim.lsp.buf_request_sync(0, "workspace/executeCommand", action, 1000)
    end

    vim.defer_fn(function()
      vim.lsp.buf.format({ async = false })
    end, 100)
  end)
end

-- Add bang support so :AddImports! is "quiet"
vim.api.nvim_create_user_command("AddImports", ts_add_missing_imports_and_format, { bang = true })
vim.keymap.set("n", "<Leader>i", ts_add_missing_imports_and_format, { desc = "Add missing imports" })
