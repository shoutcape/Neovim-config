vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 9


-- leader key
vim.g.mapleader = " "

--general sturcture for mapping keys in lua nvim
--vim.api.nvim_set_keymap('mode', 'keysToMap', 'actionOfKeys', {options})

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- delete unwanted keymaps
map('n', '<C-L>', '<Nop>', opts)
map('n', 'L', '<Nop>', opts)
map('n', '<C-,>', '<Nop>', opts)
map('n', 'S', '<Nop>', opts)

-- keymaps to move between buffers 
map('n', 'Ö', ':bprevious<CR>', opts)
map('n', 'Ä', ':bnext<CR>', opts)

--keymap to select whole page in select mode
map('n', '<leader>e', 'ggVG', opts)

--keymap to delete to void register on paste
map('x', '<leader>p', '\"_dP', opts)

-- keymaps to move around selected lines
map('v', 'J', ":m '>+1<CR>gv=gv", opts)
map('v', 'K', ":m '<-2<CR>gv=gv", opts)


-- keymaps for scrolling
map('n', '<PageUp>', '<C-u>', opts)
map('n', '<PageDown>', '<C-d>', opts)

-- yank highlighting
vim.cmd[[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END
]]


vim.api.nvim_create_user_command('Cdh', function()
    local ok, err = pcall(function()
        vim.cmd('cd ' .. vim.fn.expand('%:p:h'))
    end)
    if not ok then
        print("Error: " .. err)
    end
end,{})

