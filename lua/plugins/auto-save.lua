return {
  "okuuva/auto-save.nvim",
  event = "VeryLazy",
  opts = {
    enabled = true,
    trigger_events = {
      immediate_save = {},
      defer_save = { "TextChanged" },
      cancel_deferred_save = { "InsertEnter" },
    },
    condition = function(buf)
      -- Only write valid, modifiable, normal file buffers
      return vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modifiable and vim.bo[buf].buftype == ""
    end,
    write_all_buffers = false,
    debounce_delay = 250,
  },
}
