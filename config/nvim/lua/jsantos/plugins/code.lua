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
