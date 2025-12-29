-- LSP CONFIG AND MASON
local lspconfig = { "neovim/nvim-lspconfig", lazy = false}
local mason = { "williamboman/mason.nvim", config = true }

local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = "williamboman/mason.nvim",
	opts = {
		ensure_installed = { "lua_ls", "vimls" },
		automatic_installation = true,
		indent = true,
	},
	workspace = {
		library = vim.api.nvim_get_runtime_file("", true),
	},
}

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag", },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight        = { enable = true, },
      auto_install     = true,
      indent           = { enable = true },
      autotag          = { enable = true, },

      ensure_installed = { "json", "javascript", "typescript", "toml", "yaml", "html", "css", "python", "markdown", "markdown_inline", "go", "bash", "lua", "vim", "gitignore", "query", "vimdoc", "c", },
    })
  end,
}

local formatter = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			css = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			python = { "ruff" },
			-- sql = { "sqlruff" },
		},
		format_on_save = {
			-- lsp_fallback = true,
        -- didn't like how it formatted lua
			async = false,
			timeout_ms = 1000,
		},
	},
}


-- SQL specific plugins
	-- "tpope/vim-dadbod",
	-- "kristijanhusak/vim-dadbod-ui",

return { lspconfig, mason, mason_lspconfig, treesitter, formatter}
