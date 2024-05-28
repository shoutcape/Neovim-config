vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.number = true
vim.opt.relativenumber = true


-- leader key
vim.g.mapleader = "å"


vim.api.nvim_set_keymap('n', '<C-h>', ':bprevious<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':bnext<CR>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>e', 'ggVG', {})
vim.api.nvim_set_keymap('n', 'S', '<Nop>', { noremap = true, silent = true })


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

