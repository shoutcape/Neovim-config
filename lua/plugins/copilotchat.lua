return {
  "CopilotC-Nvim/CopilotChat.nvim",
  event = "VeryLazy",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    -- debug = true,
    mappings = {
      close = {
        normal = "q",
        insert = "<C-c>",
      },
      reset = {
        normal = "<C-l>",
        insert = "<C-l>",
      },
    },
    show_help = false,
    window = {
      layout = "vertical", --- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5,      -- fractional width of parent, or absolute width in columns when > 1
      height = 0.5,     -- fractional height of parent, or absolute height in rows when > 1
    },
  },
  vim.api.nvim_set_keymap(
    "n",
    "<leader>cp",
    ":lua require('CopilotChat').ask(vim.fn.input('Quick Chat: '), { selection = require('CopilotChat.select').buffer })<CR>",
    { noremap = true, silent = true }
  ),
}
