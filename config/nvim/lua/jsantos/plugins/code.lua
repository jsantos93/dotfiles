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

require("blink.cmp").setup({
	keymap = { preset = "enter" },
	completion = {
		accept = { auto_brackets = { enabled = true } },
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
		menu = {
			draw = {
				treesitter = { "lsp" },
				components = {
					kind_icon = {
						text = function(ctx)
							return MiniIcons.get("lsp", ctx.kind) .. ctx.icon_gap
						end,
						highlight = function(ctx)
							return select(2, MiniIcons.get("lsp", ctx.kind))
						end,
					},
				},
			},
		},
	},
	cmdline = {
		completion = {
			menu = {
				auto_show = function()
					return vim.fn.getcmdtype() == ":"
				end,
			},
			list = { selection = { preselect = false } },
		},
	},
})

vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities({
		workspace = {
			fileOperations = {
				didRename = true,
				willRename = true,
			},
		},
	}),
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

require("mini.pairs").setup({
	modes = { insert = true, command = true },
})
