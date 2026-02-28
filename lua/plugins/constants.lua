return {
	AK_root = vim.fn.stdpath("config"),
	AK_go_to_jump_options = {
		popup_opts = { border = "rounded", focusable = true, },
	},
	AK_go_to_prev = function()
		vim.diagnostic.jump({ count = -1, float = true })
	end,
	AK_go_to_next = function()
		vim.diagnostic.jump({ count = 1, float = true })
	end,
	AK_MONKA = "<C-x>",
}
