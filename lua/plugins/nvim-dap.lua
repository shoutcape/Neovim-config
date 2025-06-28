return {
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Set up dap-ui
      dapui.setup()

      -- Auto-open/close dapui with debugger
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Set up virtual text
      require("nvim-dap-virtual-text").setup()

      -- Basic keymaps
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "DAP: Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP: Toggle UI" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP: Open REPL" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "node2" }, -- Or "python", etc., depending on your language
      automatic_setup = true,
    },
    config = function(_, opts)
      require("mason-nvim-dap").setup(opts)
    end,
  },
}

