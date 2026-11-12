-- Run from the repository root:
-- nvim --clean --headless -n -i NONE -l tests/herdr_agent.lua
local agent = dofile("lua/herdr_agent.lua")
vim.notify = function() end
vim.ui.input = function(_, cb) cb("review this") end
vim.env.HERDR_ENV = "1"
vim.env.HC_TERMINAL_ID = nil
local sent
vim.system = function(cmd, _, cb)
  local result
  if cmd[3] == "list" then
    result = { agents = { { pane_id = "test-agent", cwd = vim.fn.getcwd() } } }
  else
    sent = cmd[5]
    result = {}
  end
  cb({ code = 0, stdout = vim.json.encode({ result = result }) })
end

local function fixture(first, last)
  agent.clear(true)
  vim.cmd("silent! cclose")
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_name(buf, "/tmp/opencode/herdr-review-" .. buf .. ".lua")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "one", "two", "three", "four", "five", "six", "seven" })
  vim.cmd("normal! " .. first .. "G")
  if last and last > first then
    vim.cmd("normal! V" .. (last - first) .. "j")
  end
  agent.add()
  return buf
end

local function expect_range(first, last)
  local buf = vim.api.nvim_get_current_buf()
  vim.fn.setqflist({})
  agent.list()
  local items = vim.fn.getqflist()
  vim.cmd("silent! cclose")
  vim.api.nvim_set_current_buf(buf)
  assert(#items == (first and 1 or 0), vim.inspect(items))
  if first then
    assert(items[1].lnum == first and items[1].end_lnum == last, vim.inspect(items))
  end
end

fixture(3)
vim.api.nvim_buf_set_lines(0, 2, 3, false, { "replacement" })
expect_range(3, 3)
-- Sending must include the restored comment, not merely display it in quickfix.
vim.bo.modified = false
agent.send()
assert(vim.wait(1000, function() return sent ~= nil end))
assert(sent:find(":3`", 1, true) and sent:find("review this", 1, true), sent)
expect_range(nil)

fixture(3)
vim.lsp.util.apply_text_edits({ {
  range = { start = { line = 2, character = 0 }, ["end"] = { line = 3, character = 0 } },
  newText = "LSP replacement\n",
} }, vim.api.nvim_get_current_buf(), "utf-8")
expect_range(3, 3)

fixture(3)
vim.cmd("normal! ddp")
expect_range(4, 4)

-- Identical text alone is not evidence of a move.
fixture(3)
vim.cmd("normal! dd")
vim.api.nvim_buf_set_lines(0, 5, 5, false, { "three" })
expect_range(nil)

-- An API deletion is not a cut, even if a put happens to match it.
fixture(3)
vim.fn.setreg('"', { "three" }, "V")
vim.api.nvim_buf_set_lines(0, 2, 3, false, {})
vim.cmd("normal! p")
expect_range(nil)

-- A subsequent yank makes the put a copy, not the original cut's move.
fixture(3)
vim.api.nvim_buf_set_lines(0, -1, -1, false, { "three" })
vim.cmd("normal! dd")
vim.cmd("normal! 7Gyyp")
expect_range(nil)

fixture(3)
vim.cmd("normal! dd")
vim.cmd("normal! Gothree")
expect_range(nil)

-- An intervening edit ends the move, even if the original cut register survives.
fixture(3)
vim.cmd("normal! dd")
vim.api.nvim_buf_set_lines(0, 0, 0, false, { "unrelated" })
vim.cmd("normal! p")
expect_range(nil)

for _, keys in ipairs({ "ddP", '"add"ap', "ddgp" }) do
  fixture(3)
  vim.cmd("normal! " .. keys)
  expect_range(keys == "ddP" and 3 or 4, keys == "ddP" and 3 or 4)
end

fixture(3, 4)
vim.cmd("normal! 3G2ddp")
expect_range(4, 5)

fixture(3)
vim.api.nvim_buf_set_lines(0, 2, 3, false, { "replacement one", "replacement two" })
expect_range(3, 4)

fixture(7)
vim.api.nvim_buf_set_lines(0, 6, 7, false, { "last replacement" })
expect_range(7, 7)

fixture(3, 5)
vim.cmd("normal! 5GJ")
expect_range(3, 5)

fixture(3)
vim.cmd("normal! dd")
expect_range(nil)

fixture(3)
vim.lsp.util.apply_text_edits({ {
  range = { start = { line = 2, character = 0 }, ["end"] = { line = 3, character = 0 } },
  newText = "",
} }, vim.api.nvim_get_current_buf(), "utf-8")
expect_range(nil)

fixture(3, 5)
vim.cmd("4delete")
expect_range(3, 4)
vim.cmd("3,4delete")
expect_range(nil)

for _, edit in ipairs({ "normal! ccchanged", "s/three/changed/", "normal! >>", "move 5" }) do
  fixture(3)
  vim.cmd(edit)
  expect_range(edit == "move 5" and 5 or 3, edit == "move 5" and 5 or 3)
end

-- Observe the actual redraw decorations, not the persistent tracking extmark.
fixture(3, 4)
vim.wo.signcolumn = "yes"
local signs = {}
local set_extmark = vim.api.nvim_buf_set_extmark
vim.api.nvim_buf_set_extmark = function(buf, ns, row, col, opts)
  if opts.ephemeral and opts.sign_text == "💬" then
    signs[row + 1] = true
  end
  return set_extmark(buf, ns, row, col, opts)
end
vim.cmd("redraw!")
vim.api.nvim_buf_set_extmark = set_extmark
assert(vim.deep_equal(signs, { [3] = true, [4] = true }), vim.inspect(signs))
expect_range(3, 4)

print("herdr_agent: all regression checks passed")
vim.cmd("qa!")
