-- Send code comments from Neovim to a coding agent running in a Herdr pane.
--
-- Ask now:     mark a line or selection, type a comment, it is sent at once.
-- Review mode: leave comments across files, then send them all as one prompt.
--
-- Everything goes through the `herdr` CLI, so it works with any agent Herdr
-- recognises (Claude, Codex, opencode, ...). Requires Neovim to be running
-- inside a Herdr pane.

local M = {}

local config = {
  -- Selections up to this many lines are quoted in the prompt, so the agent
  -- can still find the code if line numbers have shifted. 0 disables quoting.
  snippet_max_lines = 20,
  keys = {
    ask = "<leader>aa", -- normal + visual: comment and send now
    add = "<leader>ac", -- normal + visual: add a review comment
    send = "<leader>as", -- send all review comments
    list = "<leader>al", -- list review comments in the quickfix window
    delete = "<leader>ad", -- delete the review comment under the cursor
    clear = "<leader>ax", -- discard all review comments
    target = "<leader>at", -- choose which agent receives comments
  },
}

local ns = vim.api.nvim_create_namespace("herdr_agent_review")

---@class herdr_agent.Comment
---@field buf integer
---@field mark integer extmark id; tracks the commented range through edits
---@field text string

---@type herdr_agent.Comment[]
local comments = {}

---@type string? pane id of the agent chosen for this session
local chosen_pane

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "Herdr" })
end

local function in_herdr()
  if vim.env.HERDR_ENV == "1" then
    return true
  end
  notify("Neovim is not running inside a Herdr pane", vim.log.levels.ERROR)
  return false
end

--- Pull the human-readable message out of a failed herdr call.
local function error_message(res)
  local ok, decoded = pcall(vim.json.decode, res.stderr or "")
  if ok and type(decoded) == "table" and type(decoded.error) == "table" then
    return decoded.error.code, decoded.error.message
  end
  local raw = vim.trim((res.stderr or "") .. (res.stdout or ""))
  return nil, raw ~= "" and raw or ("herdr exited with code " .. res.code)
end

--- Run `herdr <args>` and call back with (result_table, nil) or (nil, code, message).
local function herdr(args, cb)
  local cmd = vim.list_extend({ "herdr" }, args)
  local ok, err = pcall(vim.system, cmd, { text = true }, function(res)
    vim.schedule(function()
      if res.code ~= 0 then
        cb(nil, error_message(res))
        return
      end
      local decoded_ok, decoded = pcall(vim.json.decode, res.stdout or "")
      cb(decoded_ok and type(decoded) == "table" and decoded.result or {})
    end)
  end)
  if not ok then
    cb(nil, nil, "could not run herdr: " .. tostring(err))
  end
end

local function agent_label(agent)
  local name = type(agent.name) == "string" and agent.name or nil
  local kind = type(agent.display_agent) == "string" and agent.display_agent
    or type(agent.agent) == "string" and agent.agent
    or "agent"
  local label = name and (name .. " (" .. kind .. ")") or kind
  return ("%s  %s  [%s]"):format(label, agent.pane_id, agent.agent_status or "unknown")
end

--- Resolve the agent that should receive comments and call cb(agent).
--- Order: the agent chosen earlier, else the only agent in this tab, else the
--- only agent in this workspace, else ask.
---@param force_pick boolean always show the picker
local function resolve_target(force_pick, cb)
  herdr({ "agent", "list" }, function(result, _, err)
    if not result then
      notify("Could not list agents: " .. err, vim.log.levels.ERROR)
      return
    end
    local agents = vim.tbl_filter(function(a)
      return a.pane_id ~= vim.env.HERDR_PANE_ID
    end, result.agents or {})
    if #agents == 0 then
      notify("No agents are running in Herdr", vim.log.levels.WARN)
      return
    end

    if not force_pick then
      for _, a in ipairs(agents) do
        if a.pane_id == chosen_pane then
          cb(a)
          return
        end
      end
      for _, scope in ipairs({ { "tab_id", vim.env.HERDR_TAB_ID }, { "workspace_id", vim.env.HERDR_WORKSPACE_ID } }) do
        local nearby = vim.tbl_filter(function(a)
          return scope[2] ~= nil and a[scope[1]] == scope[2]
        end, agents)
        if #nearby == 1 then
          cb(nearby[1])
          return
        elseif #nearby > 1 then
          agents = nearby
          break
        end
      end
      if #agents == 1 then
        cb(agents[1])
        return
      end
    end

    vim.ui.select(agents, { prompt = "Send comments to agent", format_item = agent_label }, function(agent)
      if agent then
        chosen_pane = agent.pane_id
        cb(agent)
      end
    end)
  end)
end

--- Path of a buffer as the agent should see it: relative to the agent's
--- working directory when the file is inside it, absolute otherwise.
local function path_for(buf, agent)
  local path = vim.api.nvim_buf_get_name(buf)
  local cwd = type(agent.cwd) == "string" and agent.cwd or nil
  if cwd then
    local rel = vim.fs.relpath(cwd, path)
    if rel then
      return rel
    end
  end
  return path
end

local function location(path, first, last)
  if first == last then
    return ("%s:%d"):format(path, first)
  end
  return ("%s:%d-%d"):format(path, first, last)
end

--- Quoted source for a range, or nil when it is too long to be worth quoting.
local function snippet(buf, first, last, indent)
  if last - first + 1 > config.snippet_max_lines then
    return nil
  end
  local lines = vim.api.nvim_buf_get_lines(buf, first - 1, last, false)
  local longest = 2
  for _, line in ipairs(lines) do
    for run in line:gmatch("`+") do
      longest = math.max(longest, #run)
    end
  end
  local fence = ("`"):rep(longest + 1)
  local out = { fence .. vim.bo[buf].filetype }
  vim.list_extend(out, lines)
  out[#out + 1] = fence
  for i, line in ipairs(out) do
    out[i] = indent .. line
  end
  return table.concat(out, "\n")
end

--- The line range the user is pointing at, leaving visual mode if needed.
local function current_range()
  local first, last = vim.fn.line("."), vim.fn.line(".")
  if vim.fn.mode():match("^[vV\22]") then
    first, last = vim.fn.line("v"), vim.fn.line(".")
    if first > last then
      first, last = last, first
    end
    vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  end
  return first, last
end

local function is_file_buffer(buf)
  if vim.bo[buf].buftype ~= "" or vim.api.nvim_buf_get_name(buf) == "" then
    notify("This buffer is not a file the agent can read", vim.log.levels.WARN)
    return false
  end
  return true
end

--- Write a modified buffer so the agent reads the same text the user sees.
local function save(buf)
  if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! update")
    end)
  end
end

local function send(agent, text, on_sent)
  herdr({ "agent", "prompt", agent.pane_id, text }, function(result, code, err)
    if not result then
      if code == "agent_blocked" then
        err = "the agent is waiting on an approval or question; answer that first"
      end
      notify("Not sent: " .. err, vim.log.levels.ERROR)
      return
    end
    on_sent()
  end)
end

--- Ask now: comment on the current line or selection and send it immediately.
function M.ask()
  if not in_herdr() then
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  if not is_file_buffer(buf) then
    return
  end
  local first, last = current_range()
  vim.ui.input({ prompt = "Ask agent: " }, function(comment)
    if not comment or vim.trim(comment) == "" then
      return
    end
    save(buf)
    resolve_target(false, function(agent)
      local parts = { ("About `%s`:"):format(location(path_for(buf, agent), first, last)) }
      parts[#parts + 1] = snippet(buf, first, last, "")
      parts[#parts + 1] = vim.trim(comment)
      send(agent, table.concat(parts, "\n\n"), function()
        notify("Sent to " .. agent_label(agent))
      end)
    end)
  end)
end

--- Comments whose buffer and extmark still exist, with their current range.
local function live_comments()
  local live = {}
  for _, c in ipairs(comments) do
    if vim.api.nvim_buf_is_valid(c.buf) then
      local pos = vim.api.nvim_buf_get_extmark_by_id(c.buf, ns, c.mark, { details = true })
      if pos[1] then
        local first = pos[1] + 1
        local last = math.max(first, (pos[3].end_row or pos[1]) + 1)
        live[#live + 1] = { comment = c, first = first, last = last }
      end
    end
  end
  comments = vim.tbl_map(function(l)
    return l.comment
  end, live)
  return live
end

--- Review mode: attach a comment to the current line or selection.
function M.add()
  local buf = vim.api.nvim_get_current_buf()
  if not is_file_buffer(buf) then
    return
  end
  local first, last = current_range()
  vim.ui.input({ prompt = "Review comment: " }, function(comment)
    if not comment or vim.trim(comment) == "" then
      return
    end
    comment = vim.trim(comment)
    local mark = vim.api.nvim_buf_set_extmark(buf, ns, first - 1, 0, {
      end_row = last - 1,
      sign_text = "💬",
      sign_hl_group = "DiagnosticInfo",
      virt_text = { { "  💬 " .. comment, "DiagnosticInfo" } },
      virt_text_pos = "eol",
    })
    comments[#comments + 1] = { buf = buf, mark = mark, text = comment }
    notify(("Review comment added (%d pending)"):format(#comments))
  end)
end

--- Review mode: send every pending comment as one prompt, then clear them.
function M.send()
  if not in_herdr() then
    return
  end
  local live = live_comments()
  if #live == 0 then
    notify("No review comments to send", vim.log.levels.WARN)
    return
  end
  for _, l in ipairs(live) do
    save(l.comment.buf)
  end
  resolve_target(false, function(agent)
    table.sort(live, function(a, b)
      local pa, pb = path_for(a.comment.buf, agent), path_for(b.comment.buf, agent)
      if pa ~= pb then
        return pa < pb
      end
      return a.first < b.first
    end)
    local parts = { ("I reviewed the code and have %d comment%s:"):format(#live, #live == 1 and "" or "s") }
    for i, l in ipairs(live) do
      local buf = l.comment.buf
      local item = { ("%d. `%s`"):format(i, location(path_for(buf, agent), l.first, l.last)) }
      item[#item + 1] = snippet(buf, l.first, l.last, "   ")
      item[#item + 1] = "   " .. l.comment.text
      parts[#parts + 1] = table.concat(item, "\n")
    end
    send(agent, table.concat(parts, "\n\n"), function()
      M.clear(true)
      notify(("Sent %d review comment%s to %s"):format(#live, #live == 1 and "" or "s", agent_label(agent)))
    end)
  end)
end

--- Review mode: show pending comments in the quickfix window.
function M.list()
  local live = live_comments()
  if #live == 0 then
    notify("No review comments", vim.log.levels.WARN)
    return
  end
  local items = vim.tbl_map(function(l)
    return { bufnr = l.comment.buf, lnum = l.first, end_lnum = l.last, text = l.comment.text }
  end, live)
  vim.fn.setqflist({}, " ", { title = "Herdr review comments", items = items })
  vim.cmd("copen")
end

--- Review mode: delete the comment covering the cursor line.
function M.delete()
  local buf, line = vim.api.nvim_get_current_buf(), vim.fn.line(".")
  for _, l in ipairs(live_comments()) do
    if l.comment.buf == buf and line >= l.first and line <= l.last then
      vim.api.nvim_buf_del_extmark(buf, ns, l.comment.mark)
      live_comments()
      notify(("Review comment deleted (%d pending)"):format(#comments))
      return
    end
  end
  notify("No review comment on this line", vim.log.levels.WARN)
end

--- Review mode: discard all pending comments.
---@param silent? boolean
function M.clear(silent)
  for _, c in ipairs(comments) do
    if vim.api.nvim_buf_is_valid(c.buf) then
      pcall(vim.api.nvim_buf_del_extmark, c.buf, ns, c.mark)
    end
  end
  comments = {}
  if not silent then
    notify("Review comments cleared")
  end
end

--- Choose which agent receives comments for the rest of this session.
function M.pick_target()
  if not in_herdr() then
    return
  end
  resolve_target(true, function(agent)
    notify("Comments now go to " .. agent_label(agent))
  end)
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
  local function map(modes, key, fn, desc)
    if key then
      vim.keymap.set(modes, key, fn, { desc = desc })
    end
  end
  local k = config.keys
  map({ "n", "x" }, k.ask, M.ask, "Agent: ask about line/selection")
  map({ "n", "x" }, k.add, M.add, "Agent: add review comment")
  map("n", k.send, M.send, "Agent: send review comments")
  map("n", k.list, M.list, "Agent: list review comments")
  map("n", k.delete, M.delete, "Agent: delete review comment")
  map("n", k.clear, M.clear, "Agent: clear review comments")
  map("n", k.target, M.pick_target, "Agent: choose target agent")
end

return M
