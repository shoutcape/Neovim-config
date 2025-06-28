return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local githubPath = vim.fn.expand("~/work/")
      local nvimPath = vim.fn.expand("~/.config/nvim")

      vim.keymap.set("n", "<Leader>ff", builtin.fd, {})
      vim.keymap.set("n", "<Leader>fp", function()
        builtin.fd({ cwd = githubPath })
      end, { desc = "find files in Github folder" })
      vim.keymap.set("n", "<Leader>fv", function()
        builtin.fd({ cwd = nvimPath })
      end, { desc = "find files in Nvim folder" })
      vim.keymap.set("n", "<leader>å", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>rs", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>lr", builtin.lsp_references, {})

      require("telescope").setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { height = 0.95, width = 0.95 },
          file_ignore_patterns = {
            "venv",
            "__pycache__",
            "%.xlsx",
            "%.jpg",
            "%.svg",
            "%.png",
            "%.webp",
            "%.pdf",
            "%.odt",
            "%.ico",
            "node_modules/*",
            "package%-lock%.json",
            "%.obsidian",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            hidden = true,
            no_ignore = true,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                -- fuzzy matching
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",   -- or "ignore_case" / "respect_case"
          },
        },
      })

      require("telescope").load_extension("fzf")
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

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}

