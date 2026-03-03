local wk = require("which-key").add
local debug_leader = "<leader>d"
local dap = require("dap")
local dapui = require("dapui")
local m = require("plugins.constants").AK_MONKA

wk {
    { debug_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "@constructor.tsx" } },
    { debug_leader .. "b", "<cmd>DapToggleBreakpoint<CR>", desc = 'Toggle Breakpoint' },
    { debug_leader .. "e", function() dapui.eval() end, desc = 'Evaluate Under Cursor' },
    { debug_leader .. m, function() dapui.toggle() end, desc = 'Toggle Ui' },
    { debug_leader .. "g", function() dap.goto() end, desc = 'Go Here' },
    { debug_leader .. "r", function() dap.restart() end, desc = 'Restart' },
    { debug_leader .."o", function()  dap.step_over() end, desc = 'Step Over' },
    { debug_leader .."i", function()  dap.step_into() end, desc = 'Step Into' },
    { debug_leader .."O", function()  dap.step_out() end, desc = 'Step Out' },
    { debug_leader .."d", function() require('dap').continue() end, desc = 'Continue' },
}


