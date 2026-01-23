return {
  {
    'echasnovski/mini.sessions',
    version = false,
    config = function()
      require('mini.sessions').setup({
        -- Directory to store session files. Must exist.
        directory = vim.fn.stdpath('data') .. '/sessions',

        -- Whether to read most recent session when Neovim is started without arguments
        autoread = false,

        -- Whether to write current session when exiting Neovim
        autowrite = true,

        -- File to use for session from startup argument
        file = '',

        -- Whether to force possibly harmful actions (meaning overwriting existing
        -- session file or using a harmful operation in 'hooks')
        force = { read = false, write = true, delete = false },

        -- Hooks to be executed at certain mini.sessions lifetime. Each hook
        -- should be a function (anything callable in Lua).
        hooks = {
          -- Before successful action (read, write, delete) is performed
          pre = { read = nil, write = nil, delete = nil },

          -- After successful action (read, write, delete) is performed
          post = { read = nil, write = nil, delete = nil },
        },

        -- Whether to print session path after action
        verbose = { read = true, write = true, delete = true },
      })

      -- Keymaps for session management
      local map = vim.keymap.set
      map('n', '<leader>ss', function()
        vim.ui.input({ prompt = 'Session name: ' }, function(name)
          if name then
            require('mini.sessions').write(name)
          end
        end)
      end, { desc = 'Save session' })

      map('n', '<leader>sl', function()
        require('mini.sessions').select('read')
      end, { desc = 'Load session' })

      map('n', '<leader>sd', function()
        require('mini.sessions').select('delete')
      end, { desc = 'Delete session' })
    end
  }
}
