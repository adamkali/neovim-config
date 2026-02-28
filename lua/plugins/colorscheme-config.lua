vim.cmd.packadd("tokyonight.nvim")
vim.cmd.packadd("vaporlush")
vim.cmd.packadd("eldritch.nvim")
local tokyonight = require("tokyonight")
local vaporlush = require("vaporlush")
local eldritch = require("eldritch")

tokyonight.setup({
	style = "night",
	transparent = true,
	lualine_bold = true,
	cache = true,
})

vaporlush.setup({
	transparent = true,
	cache = true
})

eldritch.setup({
	transparent = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = true },
	}
})
