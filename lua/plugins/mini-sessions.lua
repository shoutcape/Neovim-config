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
        force = { read = false, write = false, delete = false },

        -- Hooks to be executed at certain mini.sessions lifetime. Each hook
        -- should be a function (anything callable in Lua).
        hooks = {
          -- Before successful action (read, write, delete) is performed
          pre = { read = nil, write = nil, delete = nil },

          -- After successful action (read, write, delete) is performed
          post = { read = nil, write = nil, delete = nil },
        },

        -- Whether to print session path after action
        verbose = { read = false, write = true, delete = true },
      })
    end
  }
}
