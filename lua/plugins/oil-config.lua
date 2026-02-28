local oil = require("oil")

config = {
	default_file_explorer = true,
	skip_confirm_for_simple_edits = true,
	prompt_save_on_select_new_entry = false,
	view_options = {
		show_hidden = true
	}
}

oil.setup(config)
