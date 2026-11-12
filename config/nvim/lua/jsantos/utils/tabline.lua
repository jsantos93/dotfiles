local M = {}

local left_sep = "\u{E0BA}"
local right_sep = "\u{E0B8}"
local padding = "   "

local function label(buf)
	if vim.bo[buf].buftype == "terminal" then
		return "[Terminal]"
	end

	local path = vim.api.nvim_buf_get_name(buf)
	if path == "" then
		return "[No Name]"
	end

	local name = vim.fn.fnamemodify(path, ":t")
	if vim.fn.strchars(name) > 20 then
		name = vim.fn.strcharpart(name, 0, 17) .. "…"
	end
	return MiniIcons.get("file", path) .. " " .. name
end

function M.render()
	local current = vim.api.nvim_get_current_tabpage()
	local parts = {}

	for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local buf = vim.api.nvim_win_get_buf(vim.api.nvim_tabpage_get_win(tab))
		local hl = tab == current and "JsantosTabActive" or "JsantosTabInactive"
		local text = label(buf)
		if vim.bo[buf].modified then
			text = "[+] " .. text
		end

		table.insert(parts, ("%%#%sSep#%s%%#%s#%s%s%s%%#%sSep#%s"):format(
			hl,
			left_sep,
			hl,
			padding,
			text:gsub("%%", "%%%%"),
			padding,
			hl,
			right_sep
		))
	end

	return table.concat(parts) .. "%#TabLineFill#"
end

function M.setup()
	local c = require("solarized-osaka.colors").setup()
	vim.api.nvim_set_hl(0, "JsantosTabActive", { fg = c.base4, bg = c.yellow, bold = true })
	vim.api.nvim_set_hl(0, "JsantosTabActiveSep", { fg = c.yellow, bg = "NONE" })
	vim.api.nvim_set_hl(0, "JsantosTabInactive", { fg = c.base0, bg = c.base02 })
	vim.api.nvim_set_hl(0, "JsantosTabInactiveSep", { fg = c.base02, bg = "NONE" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE" })

	vim.o.showtabline = 1
	vim.o.tabline = "%!v:lua.Jsantos.tabline.render()"
end

return M
