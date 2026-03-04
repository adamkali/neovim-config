local overseer_leader = "<leader>v"
local wk = require("which-key").add
local overseer = require("overseer")
local m = require("plugins.constants").AK_MONKA

wk {
	{ overseer_leader, expr = false, group = "[v]im tasks", nowait = false, remap = false, icon = { icon = "", hl = "@lsp.type.interface" } }
}

wk {
	{ overseer_leader .. m, overseer.toggle, desc = 'Toggle', },
}
