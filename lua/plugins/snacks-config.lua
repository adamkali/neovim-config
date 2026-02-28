local degen_askys = {
	require "plugins.ascii.ahh",
	require "plugins.ascii.amogus",
	require "plugins.ascii.glizzy",
	require "plugins.ascii.goku",
	require "plugins.ascii.megamind",
	require "plugins.ascii.pepe",
	require "plugins.ascii.pepe_pog",
	require "plugins.ascii.soy_boy",
	require "plugins.ascii.trump",
	require "plugins.ascii.silksong",
}

local degen_messages = {
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
}

local greeting = function()
	-- get a random degen message
	return degen_messages[math.random(#degen_messages)]
end

local gif = function()
	return degen_askys[math.random(#degen_askys)]
end

local heading = function()
	return greeting() .. "\n\n" .. gif()
end


AK_snacks_keys = {
	{
		icon = " ",
		key = "f",
		desc = "Find File",
		action = "<cmd>:Telescope find_files<cr>"
	},
	{
		icon = "",
		key = "g",
		desc = "Find Text",
		action = "<cmd>:Telescope live_grep<cr>"
	},
	{
		icon = "",
		key = "r",
		desc = "Recent Files",
		action = ":lua Snacks.dashboard.pick('oldfiles')"
	},
	{
		icon = "",
		key = "c",
		desc = "Config",
		action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"
	},
	{
		icon = "",
		key = "s",
		desc = "Restore Session",
		section = "session"
	},
	{
		icon = "",
		key = "q",
		desc = "Quit",
		action = ":qa"
	},

}

AK_snacks_sections = {
	{ pane = 1, section = "header", },
	{ pane = 1, section = "keys", gap = 1, padding = 5 },
	{ pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
	{ pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 2 },
	{ pane = 2, icon = " ", title = "Git Status", cmd = "git --no-pager diff --stat -B -M -C", height = 10, },

}

local snacks_config = {
	bigfile = { enabled = true },
	dashboard = {
		enabled = true,
		preset = {
			header = heading(),
			keys = AK_snacks_keys,
		},
		sections = AK_snacks_sections,
	},
	notifier = { enabled = true },
	quickfile = { enabled = true },
	statuscolumn = { enabled = true },
	lazygit = { enabled = true },
	animate = { enabled = true },

}


vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Setup some globals for debugging (lazy-loaded)
		_G.dd = function(...)
			Snacks.debug.inspect(...)
		end
		_G.bt = function()
			Snacks.debug.backtrace()
		end
		vim.print = _G.dd -- Override print to use snacks for `:=` command

		-- Create some toggle mappings
		Snacks.toggle.inlay_hints():map("<leader>uh")
	end,
})

local snacks = require("snacks")
snacks.setup(snacks_config)


