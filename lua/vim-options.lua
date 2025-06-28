vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 20
vim.opt.termguicolors = true
vim.opt.conceallevel = 1

--automatically reload on file changes for example on git pulls
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "InsertEnter", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- leader key <leader>
vim.g.mapleader = " "

--general stucture for mapping keys in lua nvim
--vim.api.nvim_set_keymap('mode', 'keysToMap', 'actionOfKeys', {options})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- delete unwanted keymaps
map("n", "<C-L>", "<Nop>", opts)
map("n", "<C-.>", "<Nop>", opts)
map("n", "L", "<Nop>", opts)
map("n", "<C-,>", "<Nop>", opts)
map("n", "S", "<Nop>", opts)
map("n", "<C-v>", "<Nop>", opts)
map("n", "<C-G>", "<Nop>", opts)

--keymap for * not changing selection
map("n", "*", "*N", opts)

--keymap for jumping to the current tag
map("n", "<C-G>", "<C-]>", opts)

-- keymmap for visual-block mode
map("n", "ö", "<C-v>", opts)

-- keymaps to move between buffers
map("n", "Ö", ":bprevious<CR>", opts)
map("n", "Ä", ":bnext<CR>", opts)

-- keymaps to move between buffers
map("n", "Å", ":b#<CR>", opts)

--close delete buffers, close other open splits to avoid messing up splits
map("n", "<F6>", "<C-w>o:bdelete!<CR>", opts)

--keymap to select whole page in select mode or copy whole page
map("n", "vie", "maggVG", opts)
map("n", "yie", "maggVGy`a", opts)

--keymap to delete to void register on paste
map("x", "<leader>p", '"_dP', opts)

-- keymaps to move around selected lines
map("v", "J", ":m '>+1<CR>gv=gv", opts)
map("v", "K", ":m '<-2<CR>gv=gv", opts)

-- keymaps for scrolling
map("n", "<PageUp>", "<C-u>", opts)
map("n", "<PageDown>", "<C-d>", opts)

--keymap to reset last search on new search
map("n", "/", ":noh<CR>/", opts)

--keymap to create newline at next whitespace
map("n", "<leader><leader>s", "Ea<CR><BS><Esc>", opts)

--keymap to enter normal mode in terminal with esc
map("t", "<Esc>", "<C-\\><C-n>", opts)

--keymap to show error message in full length
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

--keymaps for terminal toggle
-- map("n", "<leader>ö", ":1ToggleTerm<CR>", opts)
-- map("n", "<leader>ä", ":2ToggleTerm<CR>", opts)
-- map("n", "<leader>3", ":3ToggleTerm<CR>", opts)

--keymaps to copypaste to system buffer
map("v", "<C-c>", '"*y', opts)
map("n", "<C-v>", '"*p', opts)
map("v", "<C-v>", '"*p', opts)

--keymap for control backspace
map("i", "<C-BS>", "<C-W>", opts)

--keymap to search references of current word within working directory
-- map("n", '<leader>r', [[<Cmd>execute('vimgrep /' .. expand('<cword>') .. '/j **/*')<CR>:copen<CR>]], opts)

-- yank highlighting
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]])

--keymap to cd into current buffer path
map("n", "<F18>", ":cd %:h<CR><cmd>echo getcwd() <CR>", { noremap = true, silent = true })

--keymap to copy current directory path to clipboard
map("n", "<leader>cc", ":let @+ = expand('%:h')<CR>", { noremap = true, silent = false })

--Keymap to move inside quickfixlist
map("n", "<A-Down>", ":cnext<CR>", { noremap = true, silent = true })
map("n", "<A-Up>", ":cprev<CR>", { noremap = true, silent = true })

-- Vertical resizing (height)
map("n", "<C-Down>", ":resize +6<CR>", opts) -- Increase window height
map("n", "<C-Up>", ":resize -6<CR>", opts)   -- Decrease window height

-- Horizontal resizing (width)
map("n", "<C-Left>", ":vertical resize +6<CR>", opts)  -- Increase window width
map("n", "<C-Right>", ":vertical resize -6<CR>", opts) -- Decrease window width

map("n", "<C-h>", "<C-w>h", opts) -- Move focus to the left windowMore actions
map("n", "<C-j>", "<C-w>j", opts) -- Move focus to the window below
map("n", "<C-k>", "<C-w>k", opts) -- Move focus to the window above
map("n", "<C-l>", "<C-w>l", opts) -- Move focus to the right window

map("v", "<C-h>", "<C-w>h", opts) -- Move focus to the left windowMore actions
map("v", "<C-j>", "<C-w>j", opts) -- Move focus to the window below
map("v", "<C-k>", "<C-w>k", opts) -- Move focus to the window above
map("v", "<C-l>", "<C-w>l", opts) -- Move focus to the right window


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

--keymap to toggle quickfixlist
vim.keymap.set("n", "<leader>q", toggle_quickfix, { noremap = true, silent = true })

map(
  "n",
  "<leader>cp",
  ":<C-u>lua require('CopilotChat').toggle({selection = require('CopilotChat.select').visual })<CR>",
  { noremap = true, silent = true }
)
map(
  "v",
  "<leader>cp",
  ":<C-u>lua require('CopilotChat').toggle({ selection = require('CopilotChat.select').visual })<CR>",
  { noremap = true, silent = true }
)

--keymap for find and replace
map("n", "<leader>rn", ":%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>", { noremap = true, silent = false })
map("v", "<leader>rn", "\"zy:%s/<C-r>z/<C-r>z/g<Left><Left>", { noremap = true, silent = false })


--keymap to undo and redo with cursor in place
map("n", "<leader>u", "mzu'z", { noremap = true, silent = true })
map("n", "<leader>U", "mz<C-r>'z", { noremap = true, silent = true })


map('c', '<C-BS>', '<C-W>', { noremap = true, silent=false })
