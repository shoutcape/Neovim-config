return {
  "Pocco81/auto-save.nvim",
  event = "VeryLazy",
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = function()
          return ""
        end,
      },
      trigger_events = { "TextChanged", "InsertLeave" },
      condition = function(buf)
        local utils = require("auto-save.utils.data")
        local ft = vim.bo[buf].filetype
        return vim.bo[buf].modifiable and utils.not_in(ft, { "harpoon" })
      end,
      write_all_buffers = false,
      debounce_delay = 250,
    })
  end,
}
