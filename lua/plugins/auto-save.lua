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
      trigger_events = { "TextChanged" },
      write_all_buffers = false,
      debounce_delay = 250,
    })
  end,
}
