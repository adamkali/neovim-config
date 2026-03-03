local opts = {
	-- Display settings for the preview window
	display = {
		width = 60,
		height = 12,
		y_offset = 0,
		x_offset = 0,
		filter_prompt = "󰏪 ",
	},
	-- Style settings
	style = {
		icon_set = {
			namespace = "󰋜",
			class = "",
			method = "",
			property = "",
			field = "󰽏",
			constructor = "󰡢",
			enum = "",
			interface = "",
			struct = "",
			event = "",
			operator = "",
			type_parameter = "",
			search = "",
			integer = "",
			string = "󰀬",
			boolean = "",
			array = "󰅪",
			number = "",
			null = "󰟢",
			void = "󰟢",
			object = "",
			dictionary = "",
			key = "",
			task = "",
		}
	},

	-- Symbol display options
	symbol_options = {
		namespace = true, -- show all classes in namespace
		path = 2,     -- 0-3, controls symbol path depth
	},

	-- Keybinding settings
	keybindings = {
		sharpie_local_leader = '<BS>s',
		disable_default_keybindings = true,
		preview = {
			jump_to_symbol = "<CR>", -- Jump to symbol under cursor
			next_symbol = "<C-n>", -- Navigate to next symbol
			prev_symbol = "<C-p>", -- Navigate to previous symbol
			close = "q",      -- Close preview window
			filter = ".",     -- Start filtering/searching
			clear_filter = "<Esc>", -- Clear filter and show all symbols
		}
	}
}

require("sharpie").setup(opts)
