return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,       -- Auto close tags
        enable_rename = true,      -- Auto rename matching tags
        enable_close_on_slash = false, -- Disable <slash /> auto close
        -- filetypes = { "html", "javascriptreact", "typescriptreact", "vue", "svelte" } -- Optional
      },
    })
  end,
}
