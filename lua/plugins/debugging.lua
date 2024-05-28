return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
        local dap, dapui = require("dap"), require("dapui")

        require("dapui").setup()
        require("dap-vscode-js").setup({
            adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
        })

        for _, language in ipairs({ "typescript", "javascript" }) do
            require("dap").configurations[language] = {}
        end

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    end,
}
