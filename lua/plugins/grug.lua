return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup({})

    vim.keymap.set({ "n", "v" }, "<leader>gr", ":GrugFar<CR>", { desc = "Open GrugFar" })
  end,
}
