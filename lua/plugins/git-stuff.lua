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

  -- Advanced git diff viewer
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("diffview").setup({
        -- Configuration options can be added here
      })

      -- Keymaps
      vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
      vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", { desc = "File History (current)" })
      vim.keymap.set("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>", { desc = "File History (branch)" })
      vim.keymap.set("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
      vim.keymap.set("n", "<leader>gn", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle Files Panel" })
    end,
  },
}
