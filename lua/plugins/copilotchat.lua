return {
  "CopilotC-Nvim/CopilotChat.nvim",
  event = "VeryLazy",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  opts = {
    model = 'gpt-4o',
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
    auto_follow_cursor = false,
  },
  vim.api.nvim_set_keymap(
    "n",
    "<leader>cp",
    ":lua require('CopilotChat').ask(vim.fn.input('Quick Chat: '), { selection = require('CopilotChat.select').buffer })<CR>",
    { noremap = true, silent = true }
  ),
}
