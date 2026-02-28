local wk = require('which-key').add
local m = require("plugins.constants").AK_MONKA

local telescope_leader = "<leader>f"

wk {
	{ telescope_leader, expr = false, group = "[f]inder", nowait = false, remap = false, icon = { icon = "", hl = "@lsp.type.selfTypeKeyword" } }
}

require("which-key").add {
	{ telescope_leader .. "f", "<cmd>Telescope find_files<cr>",                    desc = "Files" },
	{ telescope_leader .. "h", "<cmd>Telescope help_tags<cr>",                     desc = "Help Tags" },
	{ telescope_leader .. "g", "<cmd>Telescope live_grep<cr>",                     desc = "Grep" },
	{ telescope_leader .. "c", "<cmd>Telescope commands<cr>",                      desc = "Commands" },
	{ telescope_leader .. "b", "<cmd>Telescope buffers<cr>",                       desc = "Buffers" },
	{ telescope_leader .. "m", "<cmd>Telescope marks<cr>",                         desc = "Marks" },
	{ telescope_leader .. "r", "<cmd>Telescope registers<cr>",                     desc = "Registers" },
	{ telescope_leader .. "n", "<cmd>Telescope nerdy<cr>",                         desc = "Nerdfonts " },
	{ telescope_leader .. "k", "<cmd>Telescope keymaps<cr>",                       desc = "Keymaps" },
	{ telescope_leader .. "q", "<cmd>Telescope quickfix<cr>",                      desc = "Quickfix" },
	{ telescope_leader .. "s", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "lsp [s]ymbols" },
	{ telescope_leader .. "d", "<cmd>Telescope diagnostics<cr>",                   desc = "lsp [d]iagnostics" },
	{ telescope_leader .. "R", "<cmd>Telescope lsp_refrences<cr>",                 desc = "lsp [r]efrences" },
	{ telescope_leader .. m,   "<cmd>Telescope <cr> ",                             desc = "Open Telescope" },
}
