local language_leader = "<leader>l"
local constants = require("plugins.constants")

require("which-key").add {
	{ language_leader,  expr = false,                   group = "LSP Generic",              nowait = false, remap = true },
	{ language_leader .."c", vim.lsp.buf.code_action,        desc = 'Code action',               expr = false,   nowait = false, remap = true },
	{ language_leader .."H", vim.lsp.buf.document_highlight, desc = 'Document highlight',        expr = false,   nowait = false, remap = true },
	{ language_leader .."d", vim.lsp.buf.declaration,        desc = "Go to declaration",         expr = false,   nowait = false, remap = true },
	{ language_leader .."k", vim.lsp.buf.hover,              desc = "Show Hover Actions",        expr = false,   nowait = false, remap = true },
	{ language_leader .."R", vim.lsp.buf.references,         desc = "Find References",           expr = false,   nowait = false, remap = true },
	{ language_leader .."D", vim.lsp.buf.definition,         desc = "Go to definition",          expr = false,   nowait = false, remap = true },
	{ language_leader .."i", vim.lsp.buf.implementation,     desc = "Go to implementation",      expr = false,   nowait = false, remap = true },
	{ language_leader .."r", vim.lsp.buf.rename,             desc = "Rename File",               expr = false,   nowait = false, remap = true },
	{ language_leader .."[", constants.AK_go_to_prev,        desc = "Go to previous diagnostic", expr = false,   nowait = false, remap = true },
	{ language_leader .."]", constants.AK_go_to_next,        desc = "Go to next diagnostic",     expr = false,   nowait = false, remap = true },
	{ language_leader .."f", vim.lsp.buf.format,             desc = "Format File",               expr = false,   nowait = false, remap = true },
}
