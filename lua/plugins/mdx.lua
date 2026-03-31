return {
  "davidmh/mdx.nvim",
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- mdx.nvim registers the filetype and language mapping via after/plugin,
    -- but nvim-treesitter's highlight module doesn't auto-attach to mdx
    -- since the filetype doesn't match a parser name directly.
    -- Start treesitter highlighting manually for mdx buffers.
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "mdx",
      callback = function(args)
        vim.treesitter.start(args.buf, "markdown")
      end,
    })
  end,
}
