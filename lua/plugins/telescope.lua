return {
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   event = "VeryLazy",
  --   tag = "0.1.8",
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local builtin = require("telescope.builtin")
  --     local githubPath = "~\\Documents\\Github"
  --     local obsidianPath = "~\\Documents\\Obsidian Vault"
  --     local nvimPath = "~\\AppData\\Local\\nvim"
  --
  --     vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
  --     vim.keymap.set("n", "<Leader>fp", function()
  --       builtin.find_files({ cwd = githubPath })
  --     end, { desc = "find files in Github folder" })
  --     vim.keymap.set("n", "<Leader>fv", function()
  --       builtin.find_files({ cwd = nvimPath })
  --     end, { desc = "find files in nvim folder" })
  --     vim.keymap.set("n", "<Leader>fn", function()
  --       builtin.find_files({ cwd = obsidianPath })
  --     end, { desc = "find files in Obsidian folder" })
  --     vim.keymap.set("n", "<leader>å", builtin.git_files, {})
  --     vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
  --     vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
  --     vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
  --     vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = " Harpoon [M]arks" })
  --     vim.keymap.set("n", "<leader>rs", builtin.grep_string, {})
  --     vim.keymap.set("n", "<leader>lr", function()
  --       builtin.lsp_references({
  --         fname_width = 70,
  --         trim_text = true, -- Shows relative paths
  --       })
  --     end, { desc = "LSP references" })
  --     vim.keymap.set("v", "<leader>rs", function()
  --       local saved_reg = vim.fn.getreg('"')
  --       local saved_regtype = vim.fn.getregtype('"')
  --
  --       -- Yank the selected text into the unnamed register
  --       vim.cmd("normal! y")
  --
  --       -- Get the selected text
  --       local selected_text = vim.fn.getreg('"')
  --       -- Restore the register
  --       vim.fn.setreg('"', saved_reg, saved_regtype)
  --
  --       require("telescope.builtin").grep_string({
  --         search = selected_text,
  --         word_match = "-w",
  --         only_sort_text = true,
  --         use_regex = false, -- Treat the search string literally, not as regex
  --       })
  --     end, { desc = "Grep string from visual selection" })
  --
  --     require("telescope").setup({
  --       defaults = {
  --         layout_strategy = "vertical",
  --         layout_config = { height = 0.95, width = 0.95 },
  --         file_ignore_patterns = {
  --           "venv",
  --           "__pycache__",
  --           "%.xlsx",
  --           "%.jpg",
  --           "%.mp4",
  --           "%.png",
  --           "%.webp",
  --           "%.pdf",
  --           "%.odt",
  --           "%.ico",
  --           "node_modules/*",
  --           "package%-lock%.json",
  --           "dist/*",
  --           "My Games/*",
  --           "Programs/*",
  --           "temp/*",
  --           "npm%-cache/*",
  --           "Microsoft/*",
  --           "Pictures/*",
  --           "Saved Games/*",
  --           ".ionic/*",
  --           ".vscode/*",
  --           ".wakatime/*",
  --           ".rest%-client/*",
  --           ".chocolatey/*",
  --           ".git/*",
  --           "node_modules",
  --           "node_modules",
  --           "package-lock",
  --           "Zomboid/*",
  --           "Roaming/*",
  --           "LocalLow/*",
  --           "Packages/*",
  --           "CrossDevice/*",
  --           "%.obsidian",
  --         },
  --       },
  --       pickers = {
  --         find_files = {
  --           hidden = true,
  --           find_command = { "rg", "--files", "--hidden", "--glob", "!**\\.git\\*" },
  --           --remove most unneeded files from search
  --         },
  --       },
  --     })
  --   end,
  -- },
  --
  -- {
  --   "nvim-telescope/telescope-ui-select.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("telescope").setup({
  --       extensions = {
  --         ["ui-select"] = {
  --           require("telescope.themes").get_dropdown({}),
  --         },
  --       },
  --     })
  --     require("telescope").load_extension("ui-select")
  --   end,
  -- },
}
