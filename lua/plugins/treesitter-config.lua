local ts = require("nvim-treesitter")

-- New nvim-treesitter (main branch) only accepts install_dir in setup()
ts.setup()

-- Register custom sln parser before install list is resolved
local parsers = require("nvim-treesitter.parsers")
if parsers['sln'] == nil then
  parsers['sln'] = {
    install_info = {
      url = vim.fn.expand("~") .. "/projects/vs-solution-treesitter",
      files = { "src/parser.c" },
    },
  }
end

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
	"sln",
})

require("sln-nvim").setup({
	conceal = {
		guids = true,
		version_info = true,
		file_paths = true,
		project_lines = true,
		global_sections = true,
	},
	ui_select_backend = "telescope",
})
