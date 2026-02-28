-- Add some Quickfix Functionality
local quickfix_leader = "<leader>q"
local quickfix_enhanced = require('quickfix_enhanced')
local wk = require("which-key").add
wk { { quickfix_leader, expr = false, group = "Quickfix", nowait = false, remap = false, icon = { icon = "󰓅", hl = "Function" } } }

wk {
	{ quickfix_leader .. "a", quickfix_enhanced.qf_prev,         desc = 'Quickfix Prev',   expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "c", function() vim.cmd [[cclose]] end, desc = 'Quickfix Close',  expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "o", quickfix_enhanced.toggle_quickfix, desc = 'Quickfix Toggle', expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "s", quickfix_enhanced.qf_next,         desc = 'Quickfix Next',   expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "i", quickfix_enhanced.quickfix_info,   desc = 'Quickfix Info',   expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "x", quickfix_enhanced.clear_quickfix,  desc = 'Quickfix Clear',  expr = false, nowait = false, remap = false },
	{ quickfix_leader .. "f", quickfix_enhanced.format_quickfix, desc = 'Quickfix Format', expr = false, nowait = false, remap = false },
}
