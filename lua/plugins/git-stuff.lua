return {
  -- Git command interface
  {
    "tpope/vim-fugitive",
    event = "VeryLazy",
  },

  -- Git diff signs and blame info
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 300,
        virt_text_pos = "eol",
      },
    }, -- can be expanded with custom signs, etc.
    config = function(_, opts)
      local gitsigns = require("gitsigns")
      gitsigns.setup(opts)

      -- Keymaps
      vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview Git Hunk" })
      vim.keymap.set("n", "<leader>gt", gitsigns.toggle_current_line_blame, { desc = "Toggle Git Blame" })
    end,
  },
}
