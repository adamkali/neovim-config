local M = {}

local ascii_arts = {
	require("plugins.ascii.ahh"),
	require("plugins.ascii.amogus"),
	require("plugins.ascii.glizzy"),
	require("plugins.ascii.goku"),
	require("plugins.ascii.megamind"),
	require("plugins.ascii.pepe"),
	require("plugins.ascii.pepe_pog"),
	require("plugins.ascii.silksong"),
	require("plugins.ascii.soy_boy"),
	require("plugins.ascii.soy_point"),
	require("plugins.ascii.trump"),
}

local quotes = {
	-- degen messages (from snacks dashboard)
	"LET IT RIDE",
	"Arch btw *tips fedora*",
	"I use neovim bro",
	":poggies:",
	"🌭🌭🌭GLIZZY GLIZZY GLIZZY🌭🌭🌭",
	"M'lady",
	"All these vim motions I know so well...",
	"Per Atrioc",
	"Herm, Interesting... 🤔",
	"*Rubs belly and burps*",
	"fatchudlolcowenuinly",
	"*compiling* prayge",
	"What's wrong chat is streamer stupid?",
	"Of course i have no life how did you know?",
	"All in",
	"LETS GO GAMBLING",
	"!!!!!!SIX SEVEN!!!!!!!",
	"I just need this bug to be fixed for my parlay to hit",
	"Glory to the Tokugawa Shogunate",
	"Welcome to costco... I love you",
	"No bitches?",
	"Eww your programming that again?",
	"monka",
	"They are not bringing their best folks",
	"erm...what the sigma?",
	-- programming wisdom
	"Real programmers count from 0.",
	"It works on my machine.",
	"Have you tried turning it off and on again?",
	"There are only 10 types of people: those who understand binary and those who don't.",
	"// TODO: fix this later",
	"Debugging is twice as hard as writing the code in the first place.",
	"Always code as if the guy who ends up maintaining your code is a violent psychopath who knows where you live.",
	"The best code is no code at all.",
	"It's not a bug, it's an undocumented feature.",
	"Works on my machine... ship it.",
	"First, solve the problem. Then, write the code.",
	"Code never lies; comments sometimes do.",
	"Any fool can write code that a computer can understand. Good programmers write code that humans can understand.",
}

M.AK_NEW_BUFFER = function()
	math.randomseed(os.time())
	local art = ascii_arts[math.random(#ascii_arts)]
	local quote = quotes[math.random(#quotes)]
	local content = vim.split(art, "\n")
	table.insert(content, "")
	table.insert(content, '  "' .. quote .. '"')
	table.insert(content, "")
	vim.api.nvim_put(content, "l", false, true)
end

M.ak_new_scratch_buffer = function()
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, "[Scratch]")
	vim.bo[buf].buftype = "nofile"
	vim.bo[buf].bufhidden = "hide"
	vim.bo[buf].swapfile = false
	vim.bo[buf].filetype = "text"
	vim.api.nvim_set_current_buf(buf)
	M.AK_NEW_BUFFER()
end



M.ak_bar_datetime_end_of_day = function(days_offset)
	days_offset = days_offset or 0

	-- Calculate the target date by adding days_offset
	local current_time = os.time()
	local target_time = current_time + (days_offset * 24 * 60 * 60)
	local date = os.date("%Y-%m-%d", target_time)
	local time = "17:00:00"

	-- Concatenate
	local datetime = date .. "|" .. time
	-- write at cursor
	vim.api.nvim_put({ datetime }, "c", false, true)
end

M.ak_bar_datetime = function()
	-- Get current date and time
	local date = os.date("%Y-%m-%d")
	local time = os.date("%H:%M:%S")

	-- Concatenate
	local datetime = date .. "|" .. time
	-- write at cursor
	vim.api.nvim_put({ datetime }, "c", false, true)
end

M.ak_get_filename = function()
	local v = vim.fn.expand("%:t")
	vim.api.nvim_put({ v }, "c", false, true)
end

M.ak_get_fqn_filname = function()
	local v = vim.fn.expand("%")
	vim.api.nvim_put({ v }, "c", false, true)
end

M.ak_yank_filename = function()
	local v = vim.fn.expand("%:t")
	-- put into first register for easy pasting
	vim.fn.setreg('"', v)
end

M.ak_yank_fqn_filename = function()
	local v = vim.fn.expand("%")
	-- put into first register for easy pasting
	vim.fn.setreg('"', v)
end

M.ak_copy_filname = function()
	local v = vim.fn.expand("%:t")
	-- put into first register for easy pasting
	vim.fn.setreg('"+', v)
end

M.ak_copy_fqn_filename = function()
	local v = vim.fn.expand("%")
	-- put into first register for easy pasting
	vim.fn.setreg('"+', v)
end

M.ak_split_buffer_with_scratch = function()
	vim.cmd("split")
	M.ak_new_scratch_buffer()
end

M.ak_split_buffer_with_scratch_vertical = function()
	vim.cmd("vsplit")
	M.ak_new_scratch_buffer()
end

M.ak_run_jq_on_selected_lines = function()
	-- run jq on selected lines
	vim.cmd("'<,'>.!jq .<CR>")
end

M.ak_restart = function()
	vim.cmd("Restart")
end

return M

