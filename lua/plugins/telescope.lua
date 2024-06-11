return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")

      local githubPath = "~\\Documents\\Github"
      local nvimPath = "~\\AppData\\Local\\nvim"

      vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<Leader>fp", function() builtin.find_files({ cwd = githubPath}) end,
      { desc = "find files in Github folder"})
      vim.keymap.set("n", "<Leader>fv", function() builtin.find_files({ cwd = nvimPath}) end,
      { desc = "find files in Github folder"})
      vim.keymap.set("n", "<leader>å", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
      vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = " Harpoon [M]arks" })

      telescope.setup({
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**\\.git\\*" },
            --remove most unneeded files from search
            file_ignore_patterns = {
              "\\node_modules\\",
              "\\dist\\",
              "dist\\",
              "\\android\\",
              "\\My Games\\",
              "\\Programs\\",
              "\\Temp\\", "\\temp\\",
              "\\.git\\",
              ".git\\",
              "npm%-cache\\",
              "Microsoft\\",
              "Pictures\\",
              "Saved Games\\",
              ".android\\",
              ".gradle\\",
              ".ionic\\",
              ".vscode\\",
              ".wakatime\\",
              ".rest%-client\\",
              ".chocolatey\\",
              "\\.git\\",
              "node_modules\\",
              "Zomboid\\",
              "\\Zomboid\\",
              "\\Roaming\\",
              "\\LocalLow\\",
              "\\Packages\\",
            },
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
