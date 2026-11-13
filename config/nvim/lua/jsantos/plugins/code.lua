require("mason").setup()

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua-language-server",
		"vtsls",
		"eslint-lsp",
		"oxlint",
		"rust-analyzer",
		"copilot-language-server",
		"ty",
		"prettier",
		"prettierd",
		"oxfmt",
		"stylua",
		"shfmt",
		"ruff",
	},
	auto_update = false,
	run_on_start = true,
})

vim.lsp.config("*", {
	capabilities = {
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	},
})

vim.lsp.enable({ "lua_ls", "vtsls", "eslint", "oxlint", "rust_analyzer", "copilot", "ty" })

local icons = Jsantos.icons.diagnostics
vim.diagnostic.config({
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	virtual_text = { prefix = "●", source = "if_many" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.Error,
			[vim.diagnostic.severity.WARN] = icons.Warn,
			[vim.diagnostic.severity.HINT] = icons.Hint,
			[vim.diagnostic.severity.INFO] = icons.Info,
		},
	},
})
