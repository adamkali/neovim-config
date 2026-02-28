---@diagnostic disable: undefined-global
local obsidian      = require("obsidian")
local wk            = require("which-key").add

-- Leaders (mirrors neorg structure: <leader>o = obsidian root)
local obs           = "<leader>o"
local obs_new       = obs .. "n"   -- new note actions
local obs_find      = obs .. "f"   -- find / search
local obs_tmpl      = obs .. "t"   -- templates + todo state  (<leader>ot)
local obs_daily     = obs .. "l"   -- daily log / journal
local obs_goto      = obs .. "g"   -- goto / follow links

-- ============================================================================
-- Groups
-- ============================================================================

wk {
  { obs,       group = "[o]bsidian",      icon = { icon = "",  hl = "@function.method" } },
  { obs_new,   group = "[n]ew note",      icon = { icon = "",  hl = "@function.method" } },
  { obs_find,  group = "[f]ind",          icon = { icon = "",  hl = "@comment.hint"    } },
  { obs_tmpl,  group = "[t]odo / template", icon = { icon = "",  hl = "@comment.hint"    } },
  { obs_daily, group = "[l]og (daily)",   icon = { icon = "󰨇", hl = "@lsp.type.enum"   } },
  { obs_goto,  group = "[g]oto / follow", icon = { icon = "󱞬", hl = "@lsp.type.enum"   } },
}

-- ============================================================================
-- Root-level obsidian actions
-- ============================================================================

wk {
  { obs .. "o", obsidian.open_obsidian,           desc = "Open Obsidian",          nowait = false, remap = false },
  { obs .. "O", "<cmd>ObsidianOpen<CR>",          desc = "Open Note in App",       nowait = false, remap = false },
  { obs .. "r", "<cmd>ObsidianRename<CR>",        desc = "Rename / Refile Note",   nowait = false, remap = false },
  { obs .. "w", "<cmd>ObsidianWorkspace<CR>",     desc = "Switch Workspace",       nowait = false, remap = false },
  { obs .. "c", "<cmd>ObsidianToggleCheckbox<CR>",desc = "Toggle Checkbox",        nowait = false, remap = false },
  { obs .. "p", "<cmd>ObsidianPasteImg<CR>",      desc = "Paste Image",            nowait = false, remap = false },
  -- visual: extract selection into a new linked note
  { obs .. "x", "<cmd>ObsidianExtractNote<CR>",   desc = "Extract Selection → Note", nowait = false, remap = false, mode = "v" },
}

-- ============================================================================
-- New note  (<leader>on*)
-- ============================================================================

wk {
  -- <leader>onn  →  Create new note  (user-specified)
  { obs_new .. "n", "<cmd>ObsidianNew<CR>",            desc = "New Note",                   nowait = false, remap = false },
  -- <leader>ont  →  New note from template  (user-specified)
  { obs_new .. "t", "<cmd>ObsidianNewFromTemplate<CR>", desc = "New Note from Template",    nowait = false, remap = false },
  -- <leader>onl  →  New note, selected text becomes title + link  (user-specified, visual)
  { obs_new .. "l", "<cmd>ObsidianLinkNew<CR>",         desc = "New Note from Selection",   nowait = false, remap = false, mode = "v" },
}

-- ============================================================================
-- Find / Search  (<leader>of*)
-- ============================================================================

wk {
  -- <leader>off  →  Search linkable  (user-specified)
  { obs_find .. "f", "<cmd>ObsidianSearch<CR>",      desc = "Search Notes",       nowait = false, remap = false },
  { obs_find .. "q", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick Switch",       nowait = false, remap = false },
  { obs_find .. "l", "<cmd>ObsidianLinks<CR>",       desc = "List Links",         nowait = false, remap = false },
  { obs_find .. "b", "<cmd>ObsidianBacklinks<CR>",   desc = "Backlinks",          nowait = false, remap = false },
  { obs_find .. "d", "<cmd>ObsidianDailies<CR>",     desc = "Browse Dailies",     nowait = false, remap = false },
  { obs_find .. "t", "<cmd>ObsidianTags<CR>",        desc = "Tags",               nowait = false, remap = false },
  { obs_find .. "c", "<cmd>ObsidianTOC<CR>",         desc = "Table of Contents",  nowait = false, remap = false },
}

-- ============================================================================
-- Template  (<leader>ot*)
-- ============================================================================

wk {
  -- <leader>ott  →  Select / insert template  (user-specified)
  { obs_tmpl .. "t", "<cmd>ObsidianTemplate<CR>",        desc = "Insert Template",     nowait = false, remap = false },
  -- <leader>otn  →  New note from template  (alias — also reachable via <leader>ont)
  { obs_tmpl .. "n", "<cmd>ObsidianNewFromTemplate<CR>",  desc = "New from Template",   nowait = false, remap = false },
}

-- ============================================================================
-- Todo state  (<leader>ot*)  — mirrors neorg todo semantics
-- Updates the `todo: "..."` frontmatter field in the current obsidian note.
-- ============================================================================

--- Return the injected YAML LanguageTree for *bufnr*, or nil.
local function get_yaml_tree(bufnr)
  local ok, md = pcall(vim.treesitter.get_parser, bufnr, "markdown")
  if not ok or not md then return nil end
  md:parse()                         -- also triggers injection parsing
  local children = md:children()
  local yp = children and children["yaml"]
  if not yp then return nil end
  yp:parse()
  local trees = yp:trees()
  return (trees and #trees > 0) and trees[1] or nil
end

--- Set *field* in the YAML frontmatter of *bufnr* to *new_value*.
--- Uses treesitter to locate the exact value node and replaces only that text.
--- Returns true on success.
local function set_frontmatter_field(bufnr, field, new_value)
  local tree = get_yaml_tree(bufnr)
  if not tree then
    vim.notify("obsidian: no YAML parser / frontmatter for this buffer", vim.log.levels.WARN)
    return false
  end

  local ok_q, q = pcall(vim.treesitter.query.parse, "yaml", string.format([[
    (block_mapping_pair
      key:   (_) @key
      value: (_) @value
      (#eq? @key "%s"))
  ]], field))
  if not ok_q then
    vim.notify("obsidian: treesitter query error – " .. tostring(q), vim.log.levels.WARN)
    return false
  end

  for id, node in q:iter_captures(tree:root(), bufnr) do
    if q.captures[id] == "value" then
      local r1, c1, r2, c2 = node:range()
      vim.api.nvim_buf_set_text(bufnr, r1, c1, r2, c2, { '"' .. new_value .. '"' })
      return true
    end
  end

  vim.notify('obsidian: no `' .. field .. ':` field found in frontmatter', vim.log.levels.WARN)
  return false
end

--- Set the `todo:` frontmatter field on the current buffer.
local function set_todo(value)
  local ok = set_frontmatter_field(vim.api.nvim_get_current_buf(), "todo", value)
  if ok then vim.notify("todo → " .. value, vim.log.levels.INFO) end
end

wk {
  { obs_tmpl .. "a", function() set_todo("Uncertain") end, desc = "Todo: Uncertain", nowait = false, remap = false },
  { obs_tmpl .. "p", function() set_todo("Pending")   end, desc = "Todo: Pending",   nowait = false, remap = false },
  { obs_tmpl .. "u", function() set_todo("Undone")    end, desc = "Todo: Undone",    nowait = false, remap = false },
  { obs_tmpl .. "d", function() set_todo("Done")      end, desc = "Todo: Done",      nowait = false, remap = false },
  { obs_tmpl .. "h", function() set_todo("Hold")      end, desc = "Todo: Hold",      nowait = false, remap = false },
  { obs_tmpl .. "c", function() set_todo("Cancelled") end, desc = "Todo: Cancelled", nowait = false, remap = false },
  { obs_tmpl .. "r", function() set_todo("Recurring") end, desc = "Todo: Recurring", nowait = false, remap = false },
  { obs_tmpl .. "!", function() set_todo("Urgent")    end, desc = "Todo: Urgent",    nowait = false, remap = false },
}

-- ============================================================================
-- Daily log / Journal  (<leader>ol*)
-- ============================================================================

wk {
  { obs_daily .. "o", "<cmd>ObsidianToday<CR>",     desc = "Today",     nowait = false, remap = false },
  { obs_daily .. "y", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday", nowait = false, remap = false },
  { obs_daily .. "t", "<cmd>ObsidianTomorrow<CR>",  desc = "Tomorrow",  nowait = false, remap = false },
}

-- ============================================================================
-- Goto / Follow links  (<leader>og*)
-- ============================================================================

wk {
  { obs_goto .. "l", "<cmd>ObsidianFollowLink<CR>",        desc = "Follow Link",          nowait = false, remap = false },
  { obs_goto .. "s", "<cmd>ObsidianFollowLink vsplit<CR>",  desc = "Follow Link (vsplit)", nowait = false, remap = false },
  { obs_goto .. "h", "<cmd>ObsidianFollowLink hsplit<CR>",  desc = "Follow Link (hsplit)", nowait = false, remap = false },
}
