local leader = "<leader>c"
local config_leader = leader .. "c"
local console_leader = leader .. "t"
local wk = require("which-key").add

local hyprland_directory = function()
	-- check if we are on ubuntu 22.04
	-- if we are then we vim notify that "hypr is not available on this machine"
	if vim.loop.os_uname().version:match("22.04") then
		vim.notify("hypr is not available on this machine")
	else
		return "/home/adamkali/.config/hypr/"
	end
end
local neovim_directory = function() return os.getenv("HOME") .. "/.config/nvim/" end
local fish_directory = function() return os.getenv("HOME") .. "/.config/fish/" end
local obsidian_directory = function()
	-- check if we are on ubuntu 22.04
	-- release: 6.6.87.2-microsoft-standard-WSL2
	if vim.loop.os_uname().release:match("WSL2") then
		vim.notify("obsidian on wsl")
		return "/mnt/c/Users/adam/Documents/notes/My_Second_Mind/"
	else
		return "/home/adamkali/obsidian/"
	end
end
local tmux_config = ".tmux.conf"
local starship_config = ".config/starship.toml"
local change_directory = function(dir)
	vim.print(dir)
	vim.cmd("cd " .. dir)
end

wk {
	{ console_leader, expr = false, group = "Console", nowait = false, remap = false, icon = { icon = "", hl = "Function" } },
	{ config_leader, expr = false, group = "Configs", nowait = false, remap = false, icon = { icon = "", hl = "Function" } },
}

wk {
	{ config_leader .. "h", function() change_directory(hyprland_directory()) end, desc = "Hyprland Config", nowait = false, remap = false },
	{ config_leader .. "n", function() change_directory(neovim_directory()) end,   desc = "NeoVim Config",   nowait = false, remap = false },
	{ config_leader .. "f", function() change_directory(fish_directory()) end,     desc = "Fish Config",     nowait = false, remap = false },
	{ config_leader .. "o", function() change_directory(obsidian_directory()) end, desc = "Obsidian Config", nowait = false, remap = false },
}
-- From TJ's Wonderful 25 Days Of Neovim series

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
	floating = {
		buf = -1,
		win = -1,
	},
	bottom = {
		buf = -1,
		win = -1,
	}
}

-- The following code makes the Terminal window

local function create_floating_window(opts)
	opts = opts or {}
	local width = opts.width or math.floor(vim.o.columns * 0.8)
	local height = opts.height or math.floor(vim.o.lines * 0.8)
	local col = math.floor((vim.o.columns - width) / 2)
	local row = math.floor((vim.o.lines - height) / 2)

	-- Create a buffer
	local buf = nil
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
	end

	-- Define window configuration
	local win_config = {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		style = "minimal", -- No borders or extra UI elements
		border = "rounded",
	}

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, win_config)

	return { buf = buf, win = win }
end

-- Create Terminal Buffer
local function create_terminal_buf()
	opts = opts or {}
	-- create a new buffer and open a terminal in it
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_set_option_value("buftype", "terminal", { scope = "local", win = buf })

	-- open the terminal in the new buffer
	vim.api.nvim_command("terminal")

	return buf
end

-- Create a function callback to be used to create a key bind

local toggle_terminal = function()
	if not vim.api.nvim_win_is_valid(state.floating.win) then
		state.floating = create_floating_window { buf = state.floating.buf }
		if vim.bo[state.floating.buf].buftype ~= "terminal" then
			vim.cmd.terminal()
		end
	else
		vim.api.nvim_win_hide(state.floating.win)
	end
end

local open_buffer_terminal = function()
	local buf = create_terminal_buf()
	state.floating = create_floating_window { buf = buf }
end



-- Terminal counter for unique names
local terminal_counter = 0

-- Create a terminal in a regular buffer (like any other buffer)
local create_buffer_terminal = function()
	-- Increment counter for unique terminal names
	terminal_counter = terminal_counter + 1

	-- Create a new buffer (listed, not scratch)
	local buf = vim.api.nvim_create_buf(true, false)

	-- Set a unique name for the terminal buffer
	-- This makes it searchable through Telescope
	local term_name = string.format("term://terminal-%d", terminal_counter)
	vim.api.nvim_buf_set_name(buf, term_name)

	-- Switch to the new buffer in the current window
	vim.api.nvim_set_current_buf(buf)

	-- Start a terminal in the buffer using termopen
	-- This ensures the terminal is created in the current buffer
	local shell = vim.o.shell
	vim.fn.termopen(shell, {
		on_exit = function()
			-- Optional: close the buffer when terminal exits
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(buf) then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end)
		end
	})

	-- Set buffer options for terminal
	vim.bo[buf].buflisted = true
	vim.bo[buf].buftype = "terminal"

	-- Enter insert mode automatically
	vim.cmd.startinsert()

	return buf
end

-- Toggle bottom terminal (VSCode-like)
local toggle_bottom_terminal = function()
	-- Check if the window is valid and visible
	if vim.api.nvim_win_is_valid(state.bottom.win) then
		-- Hide the terminal window
		vim.api.nvim_win_hide(state.bottom.win)
		state.bottom.win = -1
	else
		-- Calculate height for bottom terminal (30% of screen)
		local height = math.floor(vim.o.lines * 0.3)

		-- Create or reuse buffer
		local buf = state.bottom.buf
		if not vim.api.nvim_buf_is_valid(buf) then
			buf = vim.api.nvim_create_buf(false, true)
			state.bottom.buf = buf
		end

		-- Create a split at the bottom
		vim.cmd('botright split')
		local win = vim.api.nvim_get_current_win()

		-- Set the buffer in the new window
		vim.api.nvim_win_set_buf(win, buf)

		-- Resize the window
		vim.api.nvim_win_set_height(win, height)

		-- If not already a terminal, create one
		if vim.bo[buf].buftype ~= "terminal" then
			vim.fn.termopen(vim.o.shell, {
				on_exit = function()
					vim.schedule(function()
						if vim.api.nvim_win_is_valid(win) then
							vim.api.nvim_win_close(win, true)
						end
						state.bottom.buf = -1
						state.bottom.win = -1
					end)
				end
			})
		end

		-- Store the window
		state.bottom.win = win

		-- Enter insert mode
		vim.cmd.startinsert()
	end
end

-- And the final keybinds
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.api.nvim_create_user_command("Terminal", create_buffer_terminal, {})
vim.api.nvim_create_user_command("BottomTerminal", toggle_bottom_terminal, {})

-- Terminal keymaps


wk {
	{ "<esc><esc>",          "<c-\\><c-n>",          desc = "Escape Terminal Mode",     nowait = false, remap = false, mode = "t" },
	{ "<C-M-t>",             toggle_terminal,        desc = "Toggle floating terminal", nowait = false, remap = false },
	{ console_leader .. "t", create_buffer_terminal, desc = "Open terminal in buffer",  nowait = false, remap = false },
	{ console_leader .. "b", toggle_bottom_terminal, desc = "Toggle bottom terminal",   nowait = false, remap = false },
}
