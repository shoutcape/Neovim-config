-- Clipboard for Neovim running inside Herdr or over SSH. Copies go to the local
-- Wayland clipboard when there is one and are also emitted as OSC 52, so they
-- reach the terminal on another machine. Reads use Wayland, falling back to
-- this Neovim's last copy. Never query the terminal with OSC 52: support for
-- writes does not imply permission to read, and an unanswered query blocks
-- ordinary paste for ten seconds. To insert new text from the host when no
-- readable clipboard exists, use terminal paste.
local M = {}

local function proc_lines(pid, file)
  local ok, lines = pcall(vim.fn.readfile, "/proc/" .. pid .. "/" .. file)
  return ok and lines or {}
end

local function proc_ppid(pid)
  for _, line in ipairs(proc_lines(pid, "status")) do
    local ppid = line:match("^PPid:%s+(%d+)")
    if ppid then
      return tonumber(ppid)
    end
  end
end

local function ancestor_process_named(name)
  local pid = vim.fn.getpid()

  for _ = 1, 16 do
    local ppid = proc_ppid(pid)
    if not ppid or ppid <= 1 then
      return false
    end

    local comm = proc_lines(ppid, "comm")[1] or ""
    if comm:find(name, 1, true) then
      return true
    end

    pid = ppid
  end

  return false
end

function M.setup()
  local in_ssh = vim.env.SSH_TTY ~= nil or vim.env.SSH_CONNECTION ~= nil
  local in_herdr = vim.env.HERDR_PANE_ID ~= nil or ancestor_process_named("herdr")

  if not (in_ssh or in_herdr) then
    return
  end

  local osc52 = require("vim.ui.clipboard.osc52")
  local has_wayland = vim.env.WAYLAND_DISPLAY ~= nil
    and vim.fn.executable("wl-copy") == 1
    and vim.fn.executable("wl-paste") == 1

  -- The provider cache is off, so remember each copy here: it restores the
  -- linewise/blockwise type on paste and is the fallback when nothing is readable.
  local last_copy = {}

  -- wl-paste drops the final newline that a linewise copy ends with, so compare
  -- clipboard contents without it.
  local function text(lines)
    return (table.concat(lines, "\n"):gsub("\n$", ""))
  end

  local function copy(register)
    local emit = osc52.copy(register)

    return function(lines, regtype)
      last_copy[register] = { vim.deepcopy(lines), regtype }

      if has_wayland then
        local cmd = { "wl-copy", "--type", "text/plain" }
        if register == "*" then
          cmd[#cmd + 1] = "--primary"
        end
        vim.fn.system(cmd, lines)
      end

      if vim.g.omarchy_remote_clipboard_osc52 ~= false then
        emit(lines)
      end
    end
  end

  local function paste(register)
    return function()
      if has_wayland then
        local cmd = { "wl-paste", "--no-newline" }
        if register == "*" then
          cmd[#cmd + 1] = "--primary"
        end

        local lines = vim.fn.systemlist(cmd, "", 1)
        if vim.v.shell_error == 0 then
          -- An empty clipboard is valid; only failed reads use the fallback.
          -- Our own copy comes back with the type it was yanked with.
          if last_copy[register] and text(lines) == text(last_copy[register][1]) then
            return vim.deepcopy(last_copy[register])
          end
          return lines
        end
      end

      return vim.deepcopy(last_copy[register] or { {}, "v" })
    end
  end

  vim.g.clipboard = {
    name = "OmarchyRemoteClipboard",
    copy = { ["+"] = copy("+"), ["*"] = copy("*") },
    paste = { ["+"] = paste("+"), ["*"] = paste("*") },
    cache_enabled = 0,
  }
end

return M
