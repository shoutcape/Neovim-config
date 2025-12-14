return {
  "snacks.nvim",
  opts = {
    bufdelete = {
      -- Buffer to delete. Defaults to the current buffer
      buf = nil, -- number or nil

      -- Delete buffer by file name. If provided, `buf` is ignored
      file = nil, -- string or nil

      -- Delete the buffer even if it is modified
      force = false, -- boolean

      -- Filter buffers to delete
      filter = nil, -- function(buf: number): boolean or nil

      -- Wipe the buffer instead of deleting it (see `:h :bwipeout`)
      wipe = false, -- boolean
    },
  },
}
