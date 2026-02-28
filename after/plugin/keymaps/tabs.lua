local tab_leader = "<leader>b"
local wk = require("which-key").add

-- ── Rename tab via vim.ui.input ───────────────────────────────────────────────
local rename_tab = function()
  local tab = vim.api.nvim_get_current_tabpage()
  local ok, current = pcall(vim.api.nvim_tabpage_get_var, tab, 'tabname')
  local default = (ok and current ~= '') and current or ''
  vim.ui.input({ prompt = 'Tab name: ', default = default }, function(input)
    if input == nil then return end
    vim.api.nvim_tabpage_set_var(tab, 'tabname', input)
    require('lualine').refresh()
  end)
end

-- ── Telescope tab browser ─────────────────────────────────────────────────────
local browse_tabs = function()
  local pickers      = require('telescope.pickers')
  local finders      = require('telescope.finders')
  local conf         = require('telescope.config').values
  local actions      = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  -- Build entry list from all open tabpages
  local entries = {}
  local current_tab = vim.api.nvim_get_current_tabpage()

  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local tabnr   = vim.api.nvim_tabpage_get_number(tab)
    local win     = vim.api.nvim_tabpage_get_win(tab)
    local buf     = vim.api.nvim_win_get_buf(win)
    local path    = vim.api.nvim_buf_get_name(buf)
    local relpath = path ~= '' and vim.fn.fnamemodify(path, ':~:.') or '[No Name]'
    local fname   = path ~= '' and vim.fn.fnamemodify(path, ':t')   or '[No Name]'

    -- Custom name takes priority
    local ok, custom = pcall(vim.api.nvim_tabpage_get_var, tab, 'tabname')
    local label = (ok and custom ~= '') and custom or fname

    -- Diagnostics across all windows in the tab
    local errors, warnings, hints, infos = 0, 0, 0, 0
    for _, w in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
      local b = vim.api.nvim_win_get_buf(w)
      errors   = errors   + #vim.diagnostic.get(b, { severity = vim.diagnostic.severity.ERROR })
      warnings = warnings + #vim.diagnostic.get(b, { severity = vim.diagnostic.severity.WARN })
      hints    = hints    + #vim.diagnostic.get(b, { severity = vim.diagnostic.severity.HINT })
      infos    = infos    + #vim.diagnostic.get(b, { severity = vim.diagnostic.severity.INFO })
    end

    local diag = ''
    if errors   > 0 then diag = diag .. '  ' .. errors   end
    if warnings > 0 then diag = diag .. '  ' .. warnings end
    if infos    > 0 then diag = diag .. '  ' .. infos    end
    if hints    > 0 then diag = diag .. ' 󰌶 ' .. hints    end

    local is_current = tab == current_tab and ' ' or '  '

    table.insert(entries, {
      tab     = tab,
      tabnr   = tabnr,
      label   = label,
      relpath = relpath,
      diag    = diag,
      display = string.format('%s%d  %-20s  %s%s', is_current, tabnr, label, relpath, diag),
      ordinal = label .. relpath,
    })
  end

  pickers.new({}, {
    prompt_title  = '󰓩 Tabs',
    results_title = 'Open Tabs',
    finder = finders.new_table {
      results = entries,
      entry_maker = function(e)
        return {
          value   = e,
          display = e.display,
          ordinal = e.ordinal,
          path    = vim.api.nvim_buf_get_name(
            vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(e.tab))
          ),
        }
      end,
    },
    sorter = conf.generic_sorter {},
    attach_mappings = function(prompt_bufnr, map)
      -- <CR>  → switch to tab
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local sel = action_state.get_selected_entry()
        vim.cmd(sel.value.tabnr .. 'tabnext')
      end)
      -- <C-x> → close the selected tab without leaving the picker
      map({ 'i', 'n' }, '<C-x>', function()
        local sel = action_state.get_selected_entry()
        if sel then
          vim.cmd(sel.value.tabnr .. 'tabclose')
          -- refresh picker in place
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          current_picker:refresh(finders.new_table {
            results = (function()
              local new_entries = {}
              for _, e in ipairs(entries) do
                if e.tabnr ~= sel.value.tabnr then
                  table.insert(new_entries, e)
                end
              end
              entries = new_entries
              return new_entries
            end)(),
            entry_maker = function(e)
              return { value = e, display = e.display, ordinal = e.ordinal }
            end,
          }, { reset_prompt = false })
        end
      end)
      return true
    end,
  }):find()
end

wk {
  { tab_leader, group = "Tabs", icon = { icon = "󰓩", hl = "Function" } },
}

wk {
  { tab_leader .. "b", browse_tabs,     desc = "Browse Tabs",  nowait = false, remap = false },
  { tab_leader .. "n", ":tabnew<CR>",   desc = "New Tab",      nowait = false, remap = false },
  { tab_leader .. "q", ":tabclose<CR>", desc = "Close Tab",    nowait = false, remap = false },
  { tab_leader .. "l", ":tabnext<CR>",  desc = "Next Tab",     nowait = false, remap = false },
  { tab_leader .. "h", ":tabprev<CR>",  desc = "Previous Tab", nowait = false, remap = false },
  { tab_leader .. "f", ":tabfirst<CR>", desc = "First Tab",    nowait = false, remap = false },
  { tab_leader .. "e", ":tablast<CR>",  desc = "Last Tab",     nowait = false, remap = false },
  { tab_leader .. "r", rename_tab,      desc = "Rename Tab",   nowait = false, remap = false },
  { tab_leader .. "1", "1gt",           desc = "Tab 1",        nowait = false, remap = false },
  { tab_leader .. "2", "2gt",           desc = "Tab 2",        nowait = false, remap = false },
  { tab_leader .. "3", "3gt",           desc = "Tab 3",        nowait = false, remap = false },
  { tab_leader .. "4", "4gt",           desc = "Tab 4",        nowait = false, remap = false },
  { tab_leader .. "5", "5gt",           desc = "Tab 5",        nowait = false, remap = false },
}
