local overseer_leader = "<leader>v"
local wk = require("which-key").add
local overseer = require("overseer")

wk {
	{ overseer_leader, expr = false, group = "[v]im tasks", nowait = false, remap = false, icon = { icon = "", hl = "@lsp.type.interface" } }
}

wk {
	{ overseer_leader .. "x", overseer.toggle, desc = 'Toggle', },
}
