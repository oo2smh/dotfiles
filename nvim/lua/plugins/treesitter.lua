return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	config = function()
		-- import nvim-treesitter plugin
		local treesitter = require("nvim-treesitter.configs")

		-- configure treesitter
		treesitter.setup({ -- enable syntax highlighting
			highlight = {
				enable = true,
			},
			-- enable indentation
			indent = { enable = true },
			-- enable autotagging (w/ nvim-ts-autotag plugin)
			autotag = {
				enable = true,
			},
			-- ensure these language parsers are installed
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"toml",
				"yaml",
				"html",
				"css",
				"python",
				"markdown",
				"markdown_inline",
				"go",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"vimdoc",
				"c",
			},

			--key: treesitter incremental selection
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-t>",
					node_incremental = "<C-t>",
					scope_incremental = false,
					node_decremental = "<localleader>t",
				},
			},
		})
	end,
}
