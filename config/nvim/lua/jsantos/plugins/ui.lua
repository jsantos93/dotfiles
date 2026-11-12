require("solarized-osaka").setup({
	style = "vivid",
	transparent = true,
})
vim.cmd.colorscheme("solarized-osaka")

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

Jsantos.tabline.setup()

require("lualine").setup({
	options = {
		theme = "auto",
		globalstatus = true,
		refresh = {
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
				"RecordingEnter",
				"RecordingLeave",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = {
			Jsantos.statusline.root_name,
			{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
			Jsantos.statusline.pretty_path,
		},
		lualine_x = { Jsantos.statusline.recording, "diagnostics", "diff" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("tiny-cmdline").setup({
	position = { y = "20%" },
})

require("incline").setup({
	hide = { cursorline = true },
	render = function(props)
		local path = vim.api.nvim_buf_get_name(props.buf)
		local name = path == "" and "[No Name]" or vim.fn.fnamemodify(path, ":t")
		local icon, icon_hl = MiniIcons.get("file", name)
		return {
			{ icon, group = icon_hl },
			" ",
			name,
			vim.bo[props.buf].modified and " [+]" or "",
		}
	end,
})

require("snacks").setup({
	notifier = { enabled = true },
	indent = { enabled = true },
	statuscolumn = { enabled = true },
	words = { enabled = true },
	picker = { enabled = true },
	scroll = { enabled = false },
})
