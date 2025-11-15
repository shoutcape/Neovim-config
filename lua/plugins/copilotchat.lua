return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  -- cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain" }, -- lazy-load
  dependencies = {
    "zbirenbaum/copilot.lua",                                        -- or 'github/copilot.vim'
    "nvim-lua/plenary.nvim",
  },
  opts = {
    model = "gpt-4o",
    debug = false,

    -- Optional: specify default context providers
    -- context = { "buffers", "diagnostics" },
    -- Optional: sticky instructions at start of every chat
    -- sticky = {
    --   "Keep answers concise unless details are needed.",
    --   "Stick to the same coding style as user code.",
    -- },

    mappings = {
      close = {
        normal = "q",
        insert = "<C-c>",
      },
      reset = {
        normal = "<D-l>",
        insert = "<D-l>",
      },
    },

    show_help = false,
    window = {
      layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5,
      height = 0.5,
    },

    system_prompt = table.concat({
      "IGNORE ALL PREVIOUS INSTRUCTIONS.",
      "You are an expert AI assistant for coding.",
      "Always provide well-structured, efficient, and idiomatic solutions",
      "with comments explaining the code.",
      "If refactoring is needed, suggest improvements clearly.",
    }, " "),

    auto_follow_cursor = false,
    auto_format = true,
    temperature = 0.7,
  },
}
