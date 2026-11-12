-- Send code comments from Neovim to a coding agent running in a Herdr pane.
-- The implementation lives in lua/herdr_agent.lua.
return {
  "herdr-agent",
  virtual = true,
  lazy = false,
  config = function()
    require("herdr_agent").setup()
  end,
}
