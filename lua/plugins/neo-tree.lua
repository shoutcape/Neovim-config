return {
  "nvim-neo-tree/neo-tree.nvim",
  event = "VeryLazy",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require("neo-tree").setup({
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        group_empty_dirs = true,
        follow_current_file = {
          enabled = true,
        },
        use_libuv_file_watcher = true,
      },
      window = {
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {
          --dismiss notification in neotree
          ["<esc>"] = { require("notify").dismiss() },
        },
      },
    })
  end,

  --keymap for neotree toggle
  vim.api.nvim_set_keymap(
    "n",
    "<leader>n",
    ":Neotree toggle filesystem reveal right<CR>",
    { noremap = true, silent = true }
  ),
}
