return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "main",
  dependencies = {
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    model = "claude-sonnet-4.5",
    debug = false,

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
