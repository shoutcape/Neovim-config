return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local githubPath = vim.fn.expand("~/Documents/Github")
      local nvimPath = vim.fn.expand("~/.config/nvim")

      vim.keymap.set("n", "<Leader>ff", builtin.fd, {})
      vim.keymap.set("n", "<Leader>fp", function()
        builtin.fd({ cwd = githubPath })
      end, { desc = "find files in Github folder" })
      vim.keymap.set("n", "<Leader>fv", function()
        builtin.fd({ cwd = nvimPath })
      end, { desc = "find files in Github folder" })
      vim.keymap.set("n", "<leader>å", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = " Harpoon [M]arks" })
      vim.keymap.set("n", "<leader>rs", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})

      local ignore_filetypes_list = {
        "venv", "__pycache__", "%.xlsx", "%.jpg", "%.png", "%.webp",
        "%.pdf", "%.odt", "%.ico",
      }
      require('telescope').setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { height = 0.95, width = 0.95 },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            find_command = { "fd", "--files", "--hidden", "--glob", "!**//.git//*" },
            file_ignore_patterns = ignore_filetypes_list,
          },
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
}
