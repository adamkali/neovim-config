---@diagnostic disable: undefined-global
-- [https://github.com/MeanderingProgrammer/render-markdown.nvim]
-- [https://github.com/epwalsh/obsidian.nvim]

local __render_markdown_header_config = {
	icons = { '󰼏 ', '󰼐 ', '󰼑 ', '󰼒 ', '󰼓 ', '󰼔 ' },
	position = 'inline',
	width = 'block',
	left_margin = 0,
	left_pad = 0,
	above = '▄',
	below = '▀',
	backgrounds = {
		'RenderMarkdownH1Bg',
		'RenderMarkdownH2Bg',
		'RenderMarkdownH3Bg',
		'RenderMarkdownH4Bg',
		'RenderMarkdownH5Bg',
		'RenderMarkdownH6Bg',
	},
	foregrounds = {
		'RenderMarkdownH1',
		'RenderMarkdownH2',
		'RenderMarkdownH3',
		'RenderMarkdownH4',
		'RenderMarkdownH5',
		'RenderMarkdownH6',
	},
	custom = {},
}


local __render_markdown_todo_custom_config = {
	unchecked = {
		icon = '󰄱 ',
		highlight = 'RenderMarkdownUnchecked',
		scope_highlight = nil,
	},
	checked = {
		icon = '󰩳 ',
		highlight = 'RenderMarkdownChecked',
		scope_highlight = nil,
	},
	custom = {
		pending = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
		ambiguous = { raw = '[?]', rendered = '󰞋 ', highlight = '@lsp.type.parameter', scope_highlight = nil },
		cancelled = {
			raw = '[!]',
			rendered = "`",
			highlight = '@function.method',
			scope_highlight = nil,
		},
		on_hold = {
			raw = "[h]",
			rendered = "󰏥",
			highlight = 'Comment',
			scope_highlight = nil
		},
		recurring = {
			rendered = "󱍸",
			raw = "[r]",
			highlight = '@lsp.type.builtinType',
			scope_highlight = nil
		},
		urgent = {
			rendered = "󰀧",
			raw = "[#]",
			highlight = '@lsp.type.class',
			scope_highlight = nil
		}
	},
	-- Priority to assign to scope highlight.
	scope_priority = nil,
}

local render_markdown_config = {
	file_types = { 'markdown', 'vimwiki' },
	headings = __render_markdown_header_config,
	checbox = __render_markdown_todo_custom_config
}

local obsidian_config = {
	ui = { enable = false },
	workspaces = {
		{
			name = "Notes",
			path = function()
				-- check if we are on ubuntu 22.04
				if vim.loop.os_uname().release:match("WSL") then
					return "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/"
				else
					return "/home/adamkali/obsidian/"
				end
			end,
		},
	},
	templates = {
		folder = "templates",
		date_format = "%Y-%m-%d-%a",
		time_format = "%H:%M",
		substitutions = {
			uuid = function ()
				return os.execute("uuidgen")
			end
		}
	},
}

local render_markdown = require("render-markdown")
local obsidian = require("obsidian")

render_markdown.setup(render_markdown_config)
obsidian.setup(obsidian_config)

-- ============================================================================
-- Auto-stamp `updated:` in YAML frontmatter on save (treesitter-powered)
-- Only fires for markdown files inside the configured obsidian vault.
-- ============================================================================

local function stamp_updated(bufnr)
  -- Resolve vault path the same way obsidian_config does
  local vault = vim.loop.os_uname().release:match("WSL")
    and "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/"
    or  "/home/adamkali/obsidian/"

  local path = vim.api.nvim_buf_get_name(bufnr)
  if not path:find(vault, 1, true) then return end

  -- Get markdown parser and its injected YAML child
  local ok_md, md = pcall(vim.treesitter.get_parser, bufnr, "markdown")
  if not ok_md or not md then return end
  md:parse()

  local children = md:children()
  local yp = children and children["yaml"]
  if not yp then return end
  yp:parse()

  local yaml_trees = yp:trees()
  if not yaml_trees or #yaml_trees == 0 then return end
  local yaml_root = yaml_trees[1]:root()

  local stamp = os.date("%Y-%m-%d-%a")

  -- Query: find an existing `updated:` key-value pair
  local ok_q, q = pcall(vim.treesitter.query.parse, "yaml", [[
    (block_mapping_pair
      key:   (_) @key
      value: (_) @value
      (#eq? @key "updated"))
  ]])

  if ok_q then
    for id, node in q:iter_captures(yaml_root, bufnr) do
      if q.captures[id] == "value" then
        -- Overwrite the existing value node in-place
        local r1, c1, r2, c2 = node:range()
        vim.api.nvim_buf_set_text(bufnr, r1, c1, r2, c2, { stamp })
        return
      end
    end
  end

  -- `updated:` not present — insert a new line before the closing `---`.
  -- The yaml_root range ends on the last content row; closing `---` is one row below.
  local _, _, end_row, _ = yaml_root:range()
  vim.api.nvim_buf_set_lines(bufnr, end_row + 1, end_row + 1, false,
    { "updated: " .. stamp })
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern  = "*.md",
  callback = function(ev) stamp_updated(ev.buf) end,
})
