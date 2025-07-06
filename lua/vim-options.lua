-- Set leader early to avoid remap issues
vim.g.mapleader = " "

-- Editor options
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.conceallevel = 1
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 20
vim.opt.termguicolors = true
vim.opt.autoread = true

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

-- Navigation between windows
for _, mode in ipairs({ "n", "v" }) do
  map(mode, "<A-h>", "<C-w>h")
  map(mode, "<A-j>", "<C-w>j")
  map(mode, "<A-k>", "<C-w>k")
  map(mode, "<A-l>", "<C-w>l")
end

-- Better search behavior
map("n", "*", "*N")
map("n", "/", ":noh<CR>/")

-- Buffers and tags
map("n", "Ö", ":bprevious<CR>")
map("n", "Ä", ":bnext<CR>")
map("n", "Å", ":b#<CR>")
map("n", "<C-G>", "<C-]>")
map("n", "<C-F4>", "<C-w>o:bdelete!<CR>")

-- Visual selection tweaks
map("n", "vie", "maggVG")
map("n", "yie", "maggVGy`a")
map("x", "<leader>p", '"_dP')
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Misc movement
map("n", "<PageUp>", "<C-u>")
map("n", "<PageDown>", "<C-d>")
map("n", "<leader><leader>s", "Ea<CR><BS><Esc>")
map("n", "ö", "<C-v>")

-- Terminal and diagnostics
map("t", "<Esc>", "<C-\\><C-n>")
map("n", "<space>e", vim.diagnostic.open_float)

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

-- ToggleTerm bindings
map("n", "<leader>ö", ":1ToggleTerm<CR>")
map("n", "<leader>ä", ":2ToggleTerm<CR>")

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
end)
-- Custom PowerShell script launcher (Windows)
map("n", "<leader>sh", ":!powershell C:\\Users\\kauti\\autodevenv.ps1<CR>")

map(
  "n",
  "<leader>n",
  ":Neotree toggle filesystem reveal right<CR>",
  { noremap = true, silent = true, desc = "Toggle NeoTree" }
)

map("n", "<leader>gf", vim.lsp.buf.format, {})

map("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true })

map("n", "<Esc>", "<cmd>noh<CR><cmd>lua require('notify').dismiss()<CR>", { noremap = true, silent = true })

-- Define user command and keymap to auto-import
local function add_missing_imports()
  vim.lsp.buf.code_action({
    apply = true,
    filter = function(action)
      -- Check for various possible title formats
      return action.title:lower():match("missing imports") or
             action.title:lower():match("import") or
             action.title:lower():match("add imports")
    end,
    callback = function(_, _, result)
      if not result or #result == 0 then
        vim.notify("No import actions found", vim.log.levels.WARN)
      else
        vim.notify("Imports added successfully", vim.log.levels.INFO)
      end
    end
  })
end

-- Create command :AddImports
vim.api.nvim_create_user_command("AddImports", add_missing_imports, {})

-- Optional: Add a convenient keymap
vim.keymap.set('n', '<Leader>ai', add_missing_imports, { desc = 'Add missing imports' })


