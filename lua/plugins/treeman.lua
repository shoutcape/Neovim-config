-- TreeMan.nvim — git worktree management inside Neovim
-- Ports the core TreeMan shell commands (wt, wts, wtd, lg) to native Lua
-- using snacks.nvim for UI (picker, input, notifications).

local M = {}

-- ---------------------------------------------------------------------------
-- Helpers
-- ---------------------------------------------------------------------------

--- Run a git command synchronously and return stdout (trimmed).
--- Returns nil, errmsg on failure.
---@param args string[]
---@param cwd? string
---@return string|nil, string|nil
local function git(args, cwd)
  local cmd = vim.list_extend({ "git" }, args)
  local result = vim.system(cmd, { text = true, cwd = cwd }):wait()
  if result.code ~= 0 then
    local err = (result.stderr or ""):gsub("%s+$", "")
    return nil, err
  end
  return (result.stdout or ""):gsub("%s+$", ""), nil
end

--- Run a command asynchronously. Calls `on_done(ok, stdout, stderr)` on the main thread.
---@param cmd string[]
---@param cwd? string
---@param on_done fun(ok: boolean, stdout: string, stderr: string)
local function async_cmd(cmd, cwd, on_done)
  vim.system(cmd, { text = true, cwd = cwd }, function(result)
    vim.schedule(function()
      on_done(
        result.code == 0,
        (result.stdout or ""):gsub("%s+$", ""),
        (result.stderr or ""):gsub("%s+$", "")
      )
    end)
  end)
end

--- Detect the default branch on origin (main or master).
---@return string|nil
local function detect_default_branch()
  -- Fast path: local origin/HEAD
  local head = git({ "symbolic-ref", "--quiet", "--short", "refs/remotes/origin/HEAD" })
  if head then
    head = head:gsub("^origin/", "")
    if head == "main" or head == "master" then
      return head
    end
  end
  -- Fallback: query origin
  local refs = git({ "ls-remote", "--heads", "origin", "main", "master" })
  if refs then
    if refs:match("refs/heads/main") then return "main" end
    if refs:match("refs/heads/master") then return "master" end
  end
  return nil
end

--- Return the main worktree root path.
---@return string|nil
local function main_worktree_root()
  local output = git({ "worktree", "list", "--porcelain" })
  if not output then return nil end
  return output:match("^worktree ([^\n]+)")
end

--- Convert branch name to directory slug (slashes become dashes).
---@param branch string
---@return string
local function branch_slug(branch)
  return (branch:gsub("/", "-"))
end

--- Build worktree sibling path from main root and branch name.
---@param main_root string
---@param branch string
---@return string
local function worktree_path_for_branch(main_root, branch)
  local parent = vim.fn.fnamemodify(main_root, ":h")
  local repo_name = vim.fn.fnamemodify(main_root, ":t")
  return parent .. "/" .. repo_name .. "." .. branch_slug(branch)
end

--- Parse `git worktree list` output into structured entries.
---@return {path: string, branch: string, hash: string, bare: boolean}[]
local function list_worktrees()
  local output = git({ "worktree", "list", "--porcelain" })
  if not output then return {} end

  local worktrees = {}
  local current = {}

  for line in (output .. "\n\n"):gmatch("([^\n]*)\n") do
    if line:match("^worktree ") then
      current = { path = line:match("^worktree (.+)") }
    elseif line:match("^HEAD ") then
      current.hash = line:match("^HEAD (.+)")
    elseif line:match("^branch ") then
      current.branch = line:match("^branch refs/heads/(.+)")
    elseif line == "bare" then
      current.bare = true
    elseif line == "" and current.path then
      current.branch = current.branch or "(detached)"
      current.bare = current.bare or false
      table.insert(worktrees, current)
      current = {}
    end
  end

  return worktrees
end

--- Copy .env* files from src to dest directory.
---@param src string
---@param dest string
local function copy_env_files(src, dest)
  local handle = vim.uv.fs_scandir(src)
  if not handle then return end
  local copied = 0
  while true do
    local name, ftype = vim.uv.fs_scandir_next(handle)
    if not name then break end
    if ftype == "file" and name:match("^%.env") then
      local src_file = src .. "/" .. name
      local dest_file = dest .. "/" .. name
      vim.uv.fs_copyfile(src_file, dest_file)
      copied = copied + 1
    end
  end
  if copied > 0 then
    vim.notify("Copied " .. copied .. " env file(s)", vim.log.levels.INFO)
  end
end

--- Detect lockfile and return the install command, or nil.
---@param dir string
---@return string[]|nil
local function detect_install_cmd(dir)
  local lockfiles = {
    { file = "pnpm-lock.yaml", cmd = { "pnpm", "install" } },
    { file = "yarn.lock", cmd = { "yarn", "install" } },
    { file = "package-lock.json", cmd = { "npm", "install" } },
    { file = "go.mod", cmd = { "go", "mod", "download" } },
  }
  for _, entry in ipairs(lockfiles) do
    if vim.uv.fs_stat(dir .. "/" .. entry.file) then
      if vim.fn.executable(entry.cmd[1]) == 1 then
        return entry.cmd
      end
    end
  end
  return nil
end

--- Change Neovim's cwd and notify.
---@param path string
local function cd_to(path)
  vim.cmd("cd " .. vim.fn.fnameescape(path))
  local short = path:match("([^/]+/[^/]+)$") or path
  vim.notify("cd -> " .. short, vim.log.levels.INFO)
end

-- ---------------------------------------------------------------------------
-- Commands
-- ---------------------------------------------------------------------------

--- wt: Create a new worktree + branch
---@param branch string
function M.create(branch)
  if not branch or branch == "" then
    vim.notify("TreeMan: branch name required", vim.log.levels.ERROR)
    return
  end

  -- Validate branch name
  if branch:match("[%s~%^:%?%*%[\\]") then
    vim.notify("TreeMan: branch name contains invalid characters", vim.log.levels.ERROR)
    return
  end

  local main_root = main_worktree_root()
  if not main_root then
    vim.notify("TreeMan: not inside a git repository", vim.log.levels.ERROR)
    return
  end

  local default_branch = detect_default_branch()
  if not default_branch then
    vim.notify("TreeMan: could not detect default branch (main/master)", vim.log.levels.ERROR)
    return
  end

  -- Check if branch already exists
  local existing = git({ "show-ref", "--verify", "--quiet", "refs/heads/" .. branch })
  if existing then
    vim.notify("TreeMan: branch '" .. branch .. "' already exists locally", vim.log.levels.ERROR)
    return
  end

  local wt_path = worktree_path_for_branch(main_root, branch)
  if vim.uv.fs_stat(wt_path) then
    vim.notify("TreeMan: directory already exists: " .. wt_path, vim.log.levels.ERROR)
    return
  end

  vim.notify("TreeMan: fetching " .. default_branch .. "...", vim.log.levels.INFO)

  async_cmd({ "git", "fetch", "origin", default_branch }, nil, function(ok, _, stderr)
    if not ok then
      vim.notify("TreeMan: fetch failed: " .. stderr, vim.log.levels.ERROR)
      return
    end

    vim.notify("TreeMan: creating worktree...", vim.log.levels.INFO)

    async_cmd(
      { "git", "worktree", "add", "--no-track", "-b", branch, wt_path, "origin/" .. default_branch },
      nil,
      function(wt_ok, _, wt_err)
        if not wt_ok then
          vim.notify("TreeMan: worktree creation failed: " .. wt_err, vim.log.levels.ERROR)
          return
        end

        -- Copy env files
        copy_env_files(main_root, wt_path)

        -- Install deps async
        local install_cmd = detect_install_cmd(wt_path)
        if install_cmd then
          vim.notify("TreeMan: running " .. table.concat(install_cmd, " ") .. "...", vim.log.levels.INFO)
          async_cmd(install_cmd, wt_path, function(install_ok, _, install_err)
            if not install_ok then
              vim.notify("TreeMan: install failed: " .. install_err, vim.log.levels.WARN)
            else
              vim.notify("TreeMan: dependencies installed", vim.log.levels.INFO)
            end
          end)
        end

        -- cd into new worktree
        cd_to(wt_path)
      end
    )
  end)
end

--- wts: Switch between worktrees using snacks.picker
function M.switch()
  local worktrees = list_worktrees()
  if #worktrees <= 1 then
    vim.notify("TreeMan: only one worktree exists", vim.log.levels.INFO)
    return
  end

  local cwd = vim.fn.getcwd()
  local items = {}
  for _, wt in ipairs(worktrees) do
    local short_path = wt.path:match("([^/]+/[^/]+)$") or wt.path
    table.insert(items, {
      text = short_path .. "  [" .. wt.branch .. "]",
      path = wt.path,
      branch = wt.branch,
      is_current = wt.path == cwd,
    })
  end

  require("snacks").picker({
    title = "Worktrees",
    items = items,
    format = function(item, _ctx)
      local ret = {}
      local hl = item.is_current and "DiagnosticInfo" or "Normal"
      local short_path = item.path:match("([^/]+/[^/]+)$") or item.path
      table.insert(ret, { short_path, hl })
      table.insert(ret, { "  " })
      table.insert(ret, { "[" .. item.branch .. "]", "Comment" })
      if item.is_current then
        table.insert(ret, { "  (current)", "DiagnosticHint" })
      end
      return ret
    end,
    confirm = function(picker, item)
      picker:close()
      if item and item.path ~= cwd then
        cd_to(item.path)
      elseif item then
        vim.notify("TreeMan: already in this worktree", vim.log.levels.INFO)
      end
    end,
  })
end

--- wtd: Delete a worktree using snacks.picker + confirmation
function M.delete()
  local worktrees = list_worktrees()
  local main_root = main_worktree_root()

  -- Filter out the main worktree
  local deletable = {}
  for _, wt in ipairs(worktrees) do
    if wt.path ~= main_root then
      local short_path = wt.path:match("([^/]+/[^/]+)$") or wt.path
      table.insert(deletable, {
        text = short_path .. "  [" .. wt.branch .. "]",
        path = wt.path,
        branch = wt.branch,
      })
    end
  end

  if #deletable == 0 then
    vim.notify("TreeMan: no deletable worktrees", vim.log.levels.INFO)
    return
  end

  require("snacks").picker({
    title = "Delete Worktree",
    items = deletable,
    format = function(item)
      local short_path = item.path:match("([^/]+/[^/]+)$") or item.path
      return {
        { short_path, "DiagnosticError" },
        { "  " },
        { "[" .. item.branch .. "]", "Comment" },
      }
    end,
    confirm = function(picker, item)
      picker:close()
      if not item then return end

      vim.ui.select({ "Yes", "No" }, {
        prompt = "Delete worktree " .. item.branch .. "? ",
      }, function(choice)
        if choice ~= "Yes" then
          vim.notify("TreeMan: cancelled", vim.log.levels.INFO)
          return
        end

        -- If currently inside the worktree being deleted, cd to main first
        if vim.fn.getcwd():find(item.path, 1, true) == 1 and main_root then
          cd_to(main_root)
        end

        -- Remove worktree
        local _, wt_err = git({ "worktree", "remove", item.path })
        if wt_err then
          vim.notify("TreeMan: failed to remove worktree: " .. wt_err, vim.log.levels.ERROR)
          return
        end

        -- Delete branch
        local _, br_err = git({ "branch", "-D", item.branch })
        if br_err then
          vim.notify("TreeMan: worktree removed but branch deletion failed: " .. br_err, vim.log.levels.WARN)
          return
        end

        vim.notify("TreeMan: deleted worktree and branch: " .. item.branch, vim.log.levels.INFO)
      end)
    end,
  })
end

-- ---------------------------------------------------------------------------
-- Plugin spec (lazy.nvim)
-- ---------------------------------------------------------------------------

return {
  dir = ".",
  name = "treeman",
  keys = {
    {
      "<leader>wtc",
      function()
        local row = math.floor(vim.o.lines / 2)
        vim.ui.input({
          prompt = "Branch name: ",
          win = { row = row },
        }, function(branch)
          if branch and branch ~= "" then
            M.create(branch)
          end
        end)
      end,
      desc = "TreeMan: create worktree",
    },
    { "<leader>wts", function() M.switch() end, desc = "TreeMan: switch worktree" },
    { "<leader>wtd", function() M.delete() end, desc = "TreeMan: delete worktree" },
  },
}
