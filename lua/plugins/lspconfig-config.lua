
local mason = require("mason")
local mason_config = {
	ui = {
		icons = {
			package_installed = " ",
			package_pending = "󰏖 ",
			package_uninstalled = "󰏗 "
		}
	}
}

mason.setup(mason_config)


local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.filetype.add({ extension = { templ = "templ" } })


local servers = {
	"lua_ls",
	"gopls",
	"csharp_ls",
	"docker_compose_language_service",
	"dockerls",
	"clangd",
	"html",
	"svelte",
	"marksman",
	"tailwindcss",
	"sqlls",
	"elixirls",
	"templ",
	"pyright",
	"somesass_ls",
	"hls",
	"cssls",
	"texlab",
	"rust_analyzer",
	"fish_lsp",
	"jsonls",
	"yamlls",
	"kulala_ls",
	"gleam"
}
local custom_settings = {
	csharp_ls = {
		handlers = {
			["textDocument/definition"] = require('csharpls_extended').handler,
			["textDocument/typeDefinition"] = require('csharpls_extended').handler,
		},
		settings = {
			csharp = {
				enableRoslynAnalyzers = true,
				enableImportCompletion = true,
				organizeImportsOnFormat = true,
				enableDecompilationSupport = true,
			}
		},
	},
	gopls = {
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	},
	ts_ls = {
		settings = {
			typescript = {
				inlayHints = { includeInlayParameterNameHints = "none" },
				preferences = { disableSuggestions = false },
				format = { enable = false },
				suggest = { autoImports = false },
			},
		},
	},
	svelte = {
		settings = {
			svelte = {
				format = {
					script = "",
					style = "prettier",
				},
			},
		},
	},
	tailwindcss = {
		filetypes = { "templ", "astro", "javascript", "typescript", "react", "svelte", "html" },
		settings = {
			tailwindCSS = {
				includeLanguages = { templ = "html" },
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemaStore = { enable = false, url = "" },
				schemas = require("schemastore").yaml.schemas(),
			},
		}
	},
	jsonls = {
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
	},
}

local AK_on_attatch = function(client, _)
	if client.name == "tsserver" then
		client.resolved_capabilities.document_formatting = false
	end
end


for _, server in pairs(servers) do
	local opts = {
		on_attach = AK_on_attatch,
		capabilities = capabilities,
	}
	if custom_settings[server] then
		for key, value in pairs(custom_settings[server]) do
			opts[key] = value
		end
	end
	vim.lsp.config(server, opts)
	vim.lsp.enable(server)
end


-- Now to add icons for the Diagnostics
-- Highlight entire line for errors
-- Highlight the line number for warnings
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = '󱚡',
			[vim.diagnostic.severity.WARN] = '󱚝',
			[vim.diagnostic.severity.INFO] = '󱚟',
			[vim.diagnostic.severity.HINT] = '󱚥',
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = 'ErrorMsg',
			[vim.diagnostic.severity.WARN] = 'WarningMsg',
		},
		numhl = {
			[vim.diagnostic.severity.INFO] = 'InfoMsg',
			[vim.diagnostic.severity.HINT] = 'HintMsg',
		},
	},
})
