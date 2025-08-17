-- lua/plugins/dap.lua
-- Debuggers focused on frontend: React, React Native, TypeScript & JavaScript.
-- Uses vscode-js-debug (pwa-node, pwa-chrome/msedge) via nvim-dap-vscode-js.
-- Includes presets for: web app in Chrome/Edge, Node/Next.js attach, and Jest tests.
return {
	{
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "jay-babu/mason-nvim-dap.nvim" },
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			{ "theHamsta/nvim-dap-virtual-text" },
			-- Bridge vscode-js-debug into nvim-dap (adapters: pwa-node, pwa-chrome, pwa-msedge)
			{ "mxsdev/nvim-dap-vscode-js" },
		},

		keys = {
			{ "<F5>", function() require("dap").continue() end, desc = "DAP Continue/Start", },
			{ "<F10>", function() require("dap").step_over() end, desc = "DAP Step Over", },
			{ "<F11>", function() require("dap").step_into() end, desc = "DAP Step Into", },
			{ "<F12>", function() require("dap").step_out() end, desc = "DAP Step Out", },
			{ "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP Toggle Breakpoint", },
			{ "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "DAP Conditional Breakpoint", },
			{ "<leader>dr", function() require("dap").repl.toggle() end, desc = "DAP REPL", },
			{ "<leader>dl", function() require("dap").run_last() end, desc = "DAP Run Last", },
			{ "<leader>dx", function() require("dap").terminate() end, desc = "DAP Terminate", },
			{ "<leader>du", function() require("dapui").toggle({reset=true}) end, desc = "DAP UI Toggle", },
			{ "<leader>de", function() require("dapui").eval() end, mode = { "n", "v" }, desc = "DAP Eval", },
		},

		config = function()
			local dap = require("dap")

			-- visuals
			vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DiagnosticSignWarn", linehl = "Visual" })



			-- UI + inline values
			local dapui = require("dapui")
      dapui.setup({})
			require("nvim-dap-virtual-text").setup({})
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

			-- Mason + mason-nvim-dap: ensure js-debug-adapter is installed and set up
			require("mason").setup()
			require("mason-nvim-dap").setup({
				ensure_installed = { "js" }, -- vscode-js-debug
				automatic_installation = true,
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})

			-- Explicitly tell nvim-dap-vscode-js where the debugger lives (Mason path)
			local debugger_path = vim.fn.stdpath("data")
				.. "\\mason\\packages\\js-debug-adapter\\js-debug\\src\\dapDebugServer.js"
			require("dap-vscode-js").setup({
				-- Explicitly point to Mason's js-debug install to avoid packer/path issues on Windows
				debuggerPath = debugger_path,
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
			})

			-- Setup frontend adapters for browser debugging
			for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
				local pwaType = "pwa-" .. adapterType

				dap.adapters[pwaType] = {
					type = "server",
					host = "localhost",
					port = "${port}",
					executable = {
						command = "node",
						args = {
							debugger_path,
							"${port}",
						},
					},
				}

				-- This allows handling launch.json configurations with standard types
				dap.adapters[adapterType] = function(cb, config)
					local nativeAdapter = dap.adapters[pwaType]
					config.type = pwaType
					if type(nativeAdapter) == "function" then
						nativeAdapter(cb, config)
					else
						cb(nativeAdapter)
					end
				end
			end

			-- Interactive URL input function for browser debugging
			local enter_launch_url = function()
				local co = coroutine.running()
				return coroutine.create(function()
					vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
						if url == nil or url == "" then
							return
						else
							coroutine.resume(co, url)
						end
					end)
				end)
			end

			---------------------------------------------------------------------
			-- Frontend configurations (TS/JS, React/Next) ----------------------
			---------------------------------------------------------------------
			local fts = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" }

			for _, ft in ipairs(fts) do
				dap.configurations[ft] = {
					-- Chrome browser debugging
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Chrome: Launch localhost:3000",
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
					},
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Chrome: Prompt for URL",
						url = enter_launch_url,
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
					},
					-- Edge browser debugging
					{
						type = "pwa-msedge",
						request = "launch",
						name = "Edge: Launch localhost:3000",
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						sourceMaps = true,
					},
					-- Node.js debugging (for Next.js API, Express, etc.)
					{
						type = "pwa-node",
						request = "attach",
						name = "Node: Attach to process",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					-- Jest testing
					{
						type = "pwa-node",
						request = "launch",
						name = "Jest: Debug current test file",
						cwd = "${workspaceFolder}",
						runtimeExecutable = "node",
						runtimeArgs = {
							"--inspect-brk",
							"${workspaceFolder}/node_modules/jest/bin/jest.js",
							"${file}",
							"--runInBand",
							"--config",
							"${workspaceFolder}/jest.config.js",
						},
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
				}
			end

			-- Support for launch.json
			local convertArgStringToArray = function(config)
				local c = {}
				for k, v in pairs(vim.deepcopy(config)) do
					if k == "args" and type(v) == "string" then
						c[k] = require("dap.utils").splitstr(v)
					else
						c[k] = v
					end
				end
				return c
			end

			for key, _ in pairs(dap.configurations) do
				dap.listeners.on_config[key] = convertArgStringToArray
			end
		end,
	},
}
