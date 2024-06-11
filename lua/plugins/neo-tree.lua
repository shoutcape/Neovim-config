return {
  "nvim-neo-tree/neo-tree.nvim",
  event = 'VeryLazy',
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  --keymap for neotree toggle
    vim.keymap.set("n", "<leader>n", ":Neotree toggle filesystem reveal right<CR>")
}
