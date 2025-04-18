return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"jay-babu/mason-nvim-dap.nvim",
		{
			"rcarriga/nvim-dap-ui",
			dependencies = { "nvim-neotest/nvim-nio" },
		},
	},
	config = function()
		-- Step 1: Set up mason-nvim-dap with codelldb and debugpy
		require("mason-nvim-dap").setup({
			ensure_installed = { "codelldb", "debugpy" },
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				codelldb = function(config)
					config.adapters = {
						type = "server",
						port = "${port}",
						executable = {
							command = "codelldb",
							args = { "--port", "${port}" },
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		-- Step 2: Configure DAP for C++ and Python
		local dap = require("dap")

		-- C++ Configuration with codelldb
		dap.configurations.cpp = {
			{
				name = "Launch",
				type = "codelldb",
				request = "launch",
				program = function()
					local path = vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					if vim.fn.filereadable(path) == 0 then
						vim.notify("Error: Executable not found at " .. path, vim.log.levels.ERROR)
						return nil
					end
					return path
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false, -- Pause at program entry to prevent immediate exit
				args = {},
			},
		}

		-- Python Configurations (including Django)
		dap.configurations.python = {
			{
				type = "debugpy",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				pythonPath = function()
					local venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return venv .. "/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
			},
			{
				type = "debugpy",
				request = "launch",
				name = "Django",
				program = vim.fn.getcwd() .. "/manage.py",
				args = { "runserver", "0.0.0.0:8000" },
				pythonPath = function()
					local venv = os.getenv("VIRTUAL_ENV")
					if venv then
						return venv .. "/bin/python"
					else
						return "/usr/bin/python"
					end
				end,
				django = true,
			},
		}

		-- Step 3: Set up nvim-dap-ui
		local dapui = require("dapui")
		dapui.setup()

		-- Automatically open/close UI with debugging sessions
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		-- Step 4: Define key mappings
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP: Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP: Step Out" })
		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "DAP: Set Conditional Breakpoint" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "DAP UI: Toggle" })
		vim.keymap.set("n", "<leader>de", function()
			dapui.eval(nil, { enter = true })
		end, { desc = "DAP UI: Evaluate expression under cursor" })
	end,
}
