local dap = require("dap")
local dapui = require("dapui")
local dap_virtual_text = require("nvim-dap-virtual-text")

-- UI & virtual text
dapui.setup()
dap_virtual_text.setup()

dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

local mason_bin = vim.fn.stdpath("data") .. "/mason/packages"

-- ── Python ────────────────────────────────────────────────────────────────────
dap.adapters.python = {
	type = "executable",
	command = mason_bin .. "/debugpy/venv/bin/python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3")
				or vim.fn.exepath("python")
				or "/usr/bin/python3"
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch module",
		module = function()
			return vim.fn.input("Module: ")
		end,
		pythonPath = function()
			return vim.fn.exepath("python3") ~= "" and vim.fn.exepath("python3")
				or vim.fn.exepath("python")
				or "/usr/bin/python3"
		end,
	},
}

-- ── Go (delve) ────────────────────────────────────────────────────────────────
dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = mason_bin .. "/delve/dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Debug file",
		request = "launch",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug package",
		request = "launch",
		program = "${fileDirname}",
	},
	{
		type = "go",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "go",
		name = "Debug test (package)",
		request = "launch",
		mode = "test",
		program = "${fileDirname}",
	},
	{
		type = "go",
		name = "Attach",
		request = "attach",
		mode = "local",
		processId = require("dap.utils").pick_process,
	},
}

-- ── C# (netcoredbg) ───────────────────────────────────────────────────────────
dap.adapters.coreclr = {
	type = "executable",
	command = mason_bin .. "/netcoredbg/netcoredbg",
	args = { "--interpreter=vscode" },
}

dap.configurations.cs = {
	{
		type = "coreclr",
		name = "Launch",
		request = "launch",
		program = function()
			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
		end,
	},
	{
		type = "coreclr",
		name = "Attach",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}
