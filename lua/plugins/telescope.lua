return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      local paths = {
        github = vim.fn.expand("~/work"),
        nvim = vim.fn.expand("~/.config/nvim"),
      }

      -- Keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fp", function()
        local ok = pcall(builtin.git_files, { cwd = paths.github })
        if not ok then
          builtin.find_files({ cwd = paths.github })
        end
      end, { desc = "Find in ~/work" })

      vim.keymap.set("n", "<leader>fv", function()
        local ok = pcall(builtin.git_files, { cwd = paths.nvim })
        if not ok then
          builtin.find_files({ cwd = paths.nvim })
        end
      end, { desc = "Find in config" })

      vim.keymap.set("n", "<leader>å", builtin.git_files, { desc = "Git files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>lr", function()
        builtin.lsp_references({
          fname_width = 70,
          trim_text = true,
        })
      end, { desc = "LSP references" })
      vim.keymap.set("n", "<leader>rs", builtin.grep_string, { desc = "Search word under cursor" })
      vim.keymap.set("v", "<leader>rs", function()
        local saved_reg = vim.fn.getreg('"')
        local saved_regtype = vim.fn.getregtype('"')

        -- Yank the selected text into the unnamed register
        vim.cmd("normal! y")

        -- Get the selected text
        local selected_text = vim.fn.getreg('"')
        -- Restore the register
        vim.fn.setreg('"', saved_reg, saved_regtype)

        require("telescope.builtin").grep_string({
          search = selected_text,
          word_match = "-w",
          only_sort_text = true,
          use_regex = false, -- Treat the search string literally, not as regex
        })
      end, { desc = "Grep string from visual selection" })

      -- Setup
      telescope.setup({
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
            "%.obsidian",
            "node_modules",
            "package%-lock%.json",
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = false,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!**/.git/*",
              "--glob",
              "!node_modules/*",
            },
          },
          live_grep = {
            additional_args = function()
              return { "--hidden", "--glob", "!**/.git/*", "--glob", "!node_modules/*" }
            end,
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      telescope.load_extension("fzf")
      telescope.load_extension("ui-select")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
}
