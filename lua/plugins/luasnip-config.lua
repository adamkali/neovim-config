local root = require("plugins.constants")

require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = root.AK_root .. "/snippets/" })
