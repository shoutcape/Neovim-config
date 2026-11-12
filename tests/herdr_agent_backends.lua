-- nvim --clean --headless -n -i NONE -l tests/herdr_agent_backends.lua
local agent = dofile("lua/herdr_agent.lua")
local calls, messages, picked, fail_send, malformed = {}, {}, nil, false, false
local backend = "hc"
vim.notify = function(msg) messages[#messages + 1] = msg end
vim.ui.input = function(_, cb) cb("Please check this") end
vim.ui.select = function(items, _, cb)
  picked = items
  cb(items[1])
end
local function terminal(id, tab, status)
  return {
    address = id, state = "live", cwd = "/launch",
    foreground = { cwd = vim.fn.getcwd() },
    labels = { ["herdr.tab"] = tab, ["herdr.space"] = "space" },
    status = status and { app = "opencode", state = status } or vim.NIL,
  }
end
local details = {
  self = terminal("self", "near"),
  target = terminal("target", "near", "idle"),
  far = terminal("far", "other", "idle"),
}
vim.system = function(cmd, _, cb)
  calls[#calls + 1] = cmd
  assert(cmd[1] == backend, vim.inspect(cmd))
  local result
  if cmd[1] == "hc" and cmd[2] == "ls" then
    result = { terminals = {
      { address = "self", state = "live" },
      { address = "target", state = "live", status = "idle" },
      { address = "far", state = "live", status = "idle" },
      { address = "shell", state = "live", agent = "zsh" },
      { address = "gone", state = "finished", status = "done" },
    } }
  elseif cmd[1] == "hc" and cmd[2] == "get" then
    assert(details[cmd[3]], "must not inspect shells or finished terminals")
    result = details[cmd[3]]
  elseif cmd[1] == "herdr" and cmd[3] == "list" then
    result = { agents = { { pane_id = "legacy", cwd = vim.fn.getcwd() } } }
  else
    if fail_send then
      cb({ code = 9, stderr = vim.json.encode({ error = {
        kind = "blocked", message = "approval needed",
      } }) })
      return
    end
    result = { sent = true }
  end
  cb({ code = 0, stdout = malformed and "not JSON" or vim.json.encode(
    cmd[1] == "herdr" and { result = result } or result
  ) })
end

local function flush()
  vim.wait(50, function() return false end)
end
local function fixture()
  agent.clear(true)
  calls, messages, picked = {}, {}, nil
  local buf = vim.api.nvim_create_buf(true, false)
  vim.api.nvim_set_current_buf(buf)
  vim.api.nvim_buf_set_name(buf, vim.fn.getcwd() .. "/example-" .. buf .. ".lua")
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "local value = 1" })
  vim.bo.modified = false
end
local function pending(count)
  vim.fn.setqflist({})
  agent.list()
  assert(#vim.fn.getqflist() == count)
  vim.cmd("silent! cclose")
end

vim.env.HC_TERMINAL_ID = "self"
vim.env.HERDR_ENV = nil
fixture()
agent.add()
agent.send()
flush()
local sent = calls[#calls]
assert(sent[2] == "send" and sent[3] == "target", vim.inspect(sent))
assert(sent[4]:find("Please check this", 1, true))
assert(sent[4]:find("local value = 1", 1, true))
assert(not sent[4]:find("/launch", 1, true))
assert(picked == nil, "only agent in same tab should be automatic")
pending(0)

fixture()
agent.ask()
flush()
assert(calls[#calls][2] == "send" and calls[#calls][3] == "target")
assert(calls[#calls][4]:find("About `example-", 1, true))

fixture()
agent.pick_target()
flush()
assert(picked and #picked == 2)
for _, item in ipairs(picked) do assert(item.backend == "hc") end

fixture()
fail_send = true
agent.add()
agent.send()
flush()
assert(messages[#messages]:find("waiting on an approval", 1, true))
pending(1)
fail_send = false

fixture()
malformed = true
agent.add()
agent.send()
flush()
assert(messages[#messages]:find("invalid JSON", 1, true))
pending(1)
malformed = false

-- Missing context must not invoke either CLI.
fixture()
vim.env.HC_TERMINAL_ID = nil
agent.ask()
assert(#calls == 0)
assert(messages[#messages]:find("not running inside", 1, true))

-- The same module still uses the older backend in a legacy pane.
fixture()
backend = "herdr"
vim.env.HERDR_ENV = "1"
agent.add()
agent.send()
flush()
sent = calls[#calls]
assert(sent[2] == "agent" and sent[3] == "prompt" and sent[4] == "legacy")
assert(sent[5]:find("Please check this", 1, true))
pending(0)
print("herdr_agent: backend checks passed")
vim.cmd("qa!")
