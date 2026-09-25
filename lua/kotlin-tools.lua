local M = {}

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

function M.executable(name)
  local path = mason_bin .. "/" .. name
  if vim.fn.executable(path) == 1 then
    return path
  end

  return name
end

return M
