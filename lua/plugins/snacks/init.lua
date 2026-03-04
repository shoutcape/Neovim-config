return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  import = "plugins.snacks",
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
      github = "~/Github",
      nvim = "~/.config/nvim"
    }

    return {
      -- Keep existing snacks keybindings
      { "<F6>", function() snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader><leader>", function() snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>fi", function() snacks.picker.files({ hidden = true, ignored = true }) end, desc = "Find Files (Hidden & Ignored)" },
      { "<leader>n", function() snacks.explorer() end, desc = "File Explorer" },
      { "<Leader>ff", function() snacks.picker.files() end, desc = "Find Files" },
      { "<Leader>fw", function() snacks.picker.files({ cwd = custom_paths.github }) end, desc = "Find files in Github folder" },
      { "<leader>å", function() snacks.picker.git_files() end, desc = "Git Files" },
      { "<leader>fb", function() snacks.picker.buffers() end, desc = "Buffers" },
      -- Existing find mappings
      { "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>fp", function() snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() snacks.picker.recent() end, desc = "Recent" },
      -- git
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
      { "gd", function() snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() snacks.picker.lsp_references() end, desc = "References" },
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
      { "<leader>lg", function()
        local newdir_file = vim.fn.expand("~/.lazygit/newdir")
        vim.fn.mkdir(vim.fn.expand("~/.lazygit"), "p")

        local win = snacks.lazygit({
          env = { LAZYGIT_NEW_DIR_FILE = newdir_file },
        })

        -- Snacks terminal doesn't reliably trigger win:on("TermClose") for lazygit closures.
        -- We'll register a one-shot global autocmd for the next TermClose.
        vim.api.nvim_create_autocmd("TermClose", {
          pattern = "*lazygit*",
          once = true,
          callback = function()
            vim.schedule(function()
              local f = io.open(newdir_file, "r")
              if not f then return end
              local dir = f:read("*a"):gsub("%s+$", "")
              f:close()
              os.remove(newdir_file)
              if dir ~= "" and dir ~= vim.fn.getcwd() and vim.fn.isdirectory(dir) == 1 then
                vim.cmd("cd " .. vim.fn.fnameescape(dir))
              end
            end)
          end
        })
      end, desc = "Lazygit" },
      { "<Esc>", function() vim.cmd("nohlsearch") snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    }
  end,
}
