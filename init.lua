local github_source = function(repo, opts)
	local source = { src = "https://github.com/" .. repo }
	if opts then
		source = vim.tbl_deep_extend("force", source, opts)
	end
	return source
end

vim.pack.add({
	-- colorrscheme
	github_source("adamkali/vaporlush", { version = "v2" }),             -- done
	github_source("folke/tokyonight.nvim"),                              -- done
	github_source("eldritch-theme/eldritch.nvim"),                       -- done
	-- ui
	github_source("chentoast/marks.nvim"),                               -- done
	github_source("stevearc/oil.nvim"),                                  -- done
	github_source("MunifTanjim/nui.nvim"),                               -- done
	github_source("folke/noice.nvim"),                                   -- done
	github_source("folke/snacks.nvim"),                                  -- done
	github_source("folke/which-key.nvim"),                               -- done
	github_source("nvim-tree/nvim-web-devicons"),                        -- done
	github_source("nvim-treesitter/nvim-treesitter", { version = "main" }), -- done
	github_source("nvim-lualine/lualine.nvim"),
	-- utils
	github_source("michaelrommel/nvim-silicon"), -- done
	github_source("stevearc/overseer.nvim"),    -- done
	github_source("Exafunction/windsurf.vim"),  -- done
	github_source("nvim-lua/plenary.nvim"),     -- done
	github_source("saghen/blink.cmp"),          -- done
	-- snippets
	github_source("L3MON4D3/LuaSnip"),          -- done
	github_source("rafamadriz/friendly-snippets"), -- done
	github_source("folke/lazydev.nvim"),        -- done
	-- lsp
	github_source("b0o/schemastore.nvim"),      -- done
	github_source("neovim/nvim-lspconfig"),     -- done
	github_source("mason-org/mason.nvim"),      -- done
	github_source("Decodetalkers/csharpls-extended-lsp.nvim"),
	-- fuzzy finders
	github_source("nvim-telescope/telescope.nvim"),                                        -- done
	github_source('stevearc/dressing.nvim'),                                               -- done
	github_source('2kabhishek/nerdy.nvim'),                                                -- done
	-- markdown
	github_source("MeanderingProgrammer/render-markdown.nvim"),                            -- done
	github_source("obsidian-nvim/obsidian.nvim", { version = vim.version.range "*" }), -- done
	-- nvim-dap
	github_source("mfussenegger/nvim-dap"),
	github_source("rcarriga/nvim-dap-ui"),
	github_source("theHamsta/nvim-dap-virtual-text"),
	github_source("julianolf/nvim-dap-lldb"),
	github_source("nvim-neotest/nvim-nio"),
	github_source("nvimtools/none-ls.nvim"),
	github_source("nvimtools/none-ls-extras.nvim"),
    github_source("gbprod/none-ls-luacheck.nvim"),
})

-- import options
require "opts"
-- import arbitraries
require "arbitrary"
-- import plugins directory
require "plugins"
