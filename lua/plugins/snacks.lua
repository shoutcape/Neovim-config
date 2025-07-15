return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    notifier = {enabled = true }
  },
  keys = function()
    local snacks = require("snacks")

    -- Define your custom paths
    local custom_paths = {
      github = "~/Documents/Github",
      nvim = "~/AppData/Local/nvim"
    }

    return {
      -- Keep existing snacks keybindings
      { "<F6>", function() snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader><leader>", function() snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>n", function() snacks.explorer() end, desc = "File Explorer" },
      { "<Leader>ff", function() snacks.picker.files() end, desc = "Find Files" },
      { "<Leader>fp", function() snacks.picker.files({ cwd = custom_paths.github }) end, desc = "Find files in Github folder" },
      { "<Leader>fv", function() snacks.picker.files({ cwd = custom_paths.nvim }) end, desc = "Find files in nvim folder" },
      { "<leader>å", function() snacks.picker.git_files() end, desc = "Git Files" },
      { "<leader>fb", function() snacks.picker.buffers() end, desc = "Buffers" },
      -- Existing find mappings
      { "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fp", function() snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gd", function() snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gB", function() snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      -- Grep
      { "<leader>rs", function() snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      { "<leader>fg", function() snacks.picker.grep() end, desc = "Live Grep" },
      -- search
      { '<leader>s"', function() snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sc", function() snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>fh", function() snacks.picker.help() end, desc = "Help Tags" },
      { "<leader>sH", function() snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>su", function() snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() snacks.picker.colorschemes() end, desc = "Colorschemes" },

      -- LSP
      { "gD", function() snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "<leader>lr", function() snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>cR", function() snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>lg", function() snacks.lazygit() end, desc = "Lazygit" },
      { "<Esc>", function() snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    }
  end,
}
