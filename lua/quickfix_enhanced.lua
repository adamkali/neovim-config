local M = {}

function M.qf_prev()
	local ok, err = pcall(vim.cmd, "cprev")
	if not ok then
		vim.notify(err, vim.log.levels.WARN)
	end
end

function M.qf_next()
	local ok, err = pcall(vim.cmd, "cnext")
	if not ok then
		vim.notify(err, vim.log.levels.WARN)
	end
end

function M.toggle_quickfix()
	local wins = vim.fn.getwininfo()
	for _, win in ipairs(wins) do
		if win.quickfix == 1 then
			vim.cmd("cclose")
			return
		end
	end
	vim.cmd("copen")
end

function M.quickfix_info()
	local list = vim.fn.getqflist()
	local count = #list
	if count == 0 then
		vim.notify("Quickfix list is empty", vim.log.levels.INFO)
		return
	end
	local idx = vim.fn.getqflist({ idx = 0 }).idx
	vim.notify(string.format("Quickfix: %d/%d", idx, count), vim.log.levels.INFO)
end

function M.clear_quickfix()
	vim.fn.setqflist({})
	vim.notify("Quickfix list cleared", vim.log.levels.INFO)
end

function M.format_quickfix()
	local list = vim.fn.getqflist()
	if #list == 0 then
		vim.notify("Quickfix list is empty", vim.log.levels.INFO)
		return
	end
	local formatted = {}
	for _, item in ipairs(list) do
		local fname = item.bufnr > 0 and vim.fn.bufname(item.bufnr) or ""
		table.insert(formatted, {
			filename = fname,
			lnum = item.lnum,
			col = item.col,
			text = item.text,
		})
	end
	vim.fn.setqflist(formatted, "r")
	vim.notify("Quickfix list formatted", vim.log.levels.INFO)
end

return M
