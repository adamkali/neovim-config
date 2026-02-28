
vim.cmd.packadd("lazydev.nvim")
vim.cmd.packadd("blink.cmp")

local lazydev = require("lazydev")

lazydev.setup {
	library = {
		"lazy.nvim",
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ path = "LazyVim",            words = { "LazyVim" } },
	},
	-- always enable unless `vim.g.lazydev_enabled = false`
	-- This is the default
	enabled = function(_)
		return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
	end,
}

local blink = require("blink.cmp")

local AK_cmp_icons = {
	Text = '',
	Method = '󰊕',
	Function = '󰘧',
	Constructor = '󰢈',
	Field = '󰀫',
	Variable = ' 󰂡',
	Property = '',
	Class = '󱥒',
	Interface = '󰯙',
	Module = '',
	Struct = '󰐱',
	Unit = '',
	Value = '󰏉',
	Enum = '',
	EnumMember = '',
	Keyword = '',
	Constant = '',
	Snippet = '',
	Color = '󰏘',
	File = '󰈔',
	Reference = '󰬲',
	Folder = '󰉋',
	Event = '󱐋',
	Operator = '󰒠',
	TypeParameter = '󱃮',
}

local text_clbk = function(ctx)
	-- we will channge thes icons
	local icon = ctx.kind_icon
	if AK_cmp_icons[ctx.kind] then
		icon = AK_cmp_icons[ctx.kind]
	else
		icon = AK_cmp_icons[ctx.source_name]
	end

	return icon .. ctx.icon_gap
end

local highlight_clbk = function(ctx)
	local hl = ctx.kind_hl
	if vim.tbl_contains({ "Path" }, ctx.source_name) then
		local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
		if dev_icon then
			hl = dev_hl
		end
	end
	return hl
end

local blink_config = {
	keymap = { preset = 'default' },
	appearance = { nerd_font_variant = 'propo' },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			border = 'rounded',
			draw = {
				components = { kind_icon = { text = text_clbk, highlight = highlight_clbk, } }
			}
		}
	},
	sources = {
		-- default = { 'lsp', 'path', 'snippets', 'lazydev', },
		default = { 'path', 'snippets', 'lazydev', },
		providers = {
			lazydev = { module = 'lazydev.integrations.blink', score_offset = 100, },
		},
	},
	snippets = { preset = 'luasnip' },
	fuzzy = { implementation = 'lua' },
	signature = { enabled = true },
}

blink.setup(blink_config)
