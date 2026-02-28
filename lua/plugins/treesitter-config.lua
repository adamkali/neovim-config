local ts = require("nvim-treesitter")

-- New nvim-treesitter (main branch) only accepts install_dir in setup()
ts.setup()

-- Highlighting is now enabled per-buffer via vim.treesitter.start()
vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		pcall(vim.treesitter.start, ev.buf)
	end,
})

-- Parser installation is now done via :TSInstall or ts.install()
ts.install({
	"bash",
	"c",
	"cpp",
	"c_sharp",
	"css",
	"comment",
	"dockerfile",
	"elixir",
	"fish",
	"gitignore",
	"go",
	"gowork",
	"gomod",
	"gosum",
	"html",
	"lua",
	"javascript",
	"typescript",
	"tsx",
	"python",
	"rust",
	"markdown",
	"markdown_inline",
	"templ",
	"gleam",
})
