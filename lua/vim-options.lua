vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.scrolloff = 9


-- leader key
vim.g.mapleader = " "

-- keymaps to move between buffers 
vim.api.nvim_set_keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })

--keymap to select whole page in select mode
vim.keymap.set('v', '<leader>e', 'ggVG', {})
vim.api.nvim_set_keymap('n', 'S', '<Nop>', { noremap = true, silent = true })

-- keymaps to move around selected lines
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })


-- keymaps for scrolling
vim.api.nvim_set_keymap('n', '<PageUp>', '<C-u>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<PageDown>', '<C-d>', { noremap = true, silent = true })

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

