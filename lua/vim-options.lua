vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 20
vim.opt.termguicolors = true

--automatically reload on file changes for example on git pulls
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "InsertEnter", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- leader key
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

-- keymap to move between last and current buffer
map("n", "Å", ":b#<CR>", opts)

--close delete buffers, close other open splits to avoid messing up splits
map("n", "<C-F4>", "<C-w>o:bdelete!<CR>", opts)

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

--keymap to exit terminal with esc
map("t", "<Esc>", "<C-\\><C-n>", opts)

--keymap to show error message in full length
map("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

--keymaps for terminal toggle
map("n", "<leader>ö", ":1ToggleTerm<CR>", opts)
map("n", "<leader>ä", ":2ToggleTerm<CR>", opts)
-- map("n", "<leader>3", ":3ToggleTerm<CR>", opts)

--keymaps to copypaste to system buffer
map("v", "<C-c>", '"*y', opts)
map("n", "<C-v>", '"*p', opts)
map("v", "<C-v>", '"*p', opts)

--keymap for control backspace
map("i", "<C-BS>", "<C-W>", opts)

--keymap to empty notify

--keymap for possible pwsh scripts
map("n", "<leader>sh", ":!powershell C:\\Users\\kauti\\autodevenv.ps1<CR>", opts)

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

--keymap to run current file in python
map("n", "<A-a>", ':TermExec cmd="python %:p" dir=%:h size=10 direction=horizontal <CR>', { noremap = true, silent = true })

