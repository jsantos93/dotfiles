local M = {}

local root_markers = { { ".git", "lua", "package.json", "Makefile", "Cargo.toml", "go.mod", "pyproject.toml" } }

function M.root_name()
	local root = vim.fs.root(0, root_markers)
	if not root or root == vim.fn.getcwd() then
		return ""
	end
	return vim.fs.basename(root)
end

function M.pretty_path()
	local path = vim.api.nvim_buf_get_name(0)
	if path == "" then
		return ""
	end

	local parts = vim.split(vim.fn.fnamemodify(path, ":~:."), "/", { plain = true })
	if #parts > 3 then
		parts = { "…", unpack(parts, #parts - 2) }
	end
	return table.concat(parts, "/")
end

function M.recording()
	local reg = vim.fn.reg_recording()
	if reg == "" then
		return ""
	end
	return "recording @" .. reg
end

return M
