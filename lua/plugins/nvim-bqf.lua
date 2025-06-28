return {
  "kevinhwang91/nvim-bqf",
  ft = "qf", -- Load only when quickfix window is opened
  opts = {
    -- Default configuration
    auto_enable = true,
    preview = {
      win_height = 32,
      win_vheight = 32,
      delay_syntax = 80,
      border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
    },
    func_map = {
      vsplit = "",
      ptogglemode = "z,",
      stoggleup = "",
    },
    filter = {
      fzf = {
        action_for = { ["ctrl-t"] = "tab split" },
        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " }
      }
    }
  },
}
