-- h: LSP CONFIG AND MASON
local lspconfig = { "neovim/nvim-lspconfig", lazy = false }
local mason = { "williamboman/mason.nvim", config = true }
mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = "williamboman/mason.nvim",
	opts = {
		ensure_installed = { "lua_ls", "vimls" },
		automatic_installation = true,
	},
	workspace = {
		library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
	},
}

-- h: BLINK COMPLETION ENGINE
local blink = {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },
	version = "1.*",

	opts = {
		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = false } },
		sources = {
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
			},
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

-- h: LAZY DEV: Remove global vim api warning:
local lazydev = {
	"folke/lazydev.nvim",
	ft = "lua",
	opts = {
		library = {
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	},
}

return { lspconfig, mason, mason_lspconfig, blink, lazydev }
