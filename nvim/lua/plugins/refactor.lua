local formatter = {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			lua = { "stylua" },
			python = { "pylint", "ruff" },
			sql = { "sqlruff" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	},
	init = function()
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			require("conform").format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}

local linter = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		linters_by_ft = {
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			python = { "ruff" },
		},
	},
	init = function()
		local lint = require("lint")

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})
		-- key: Lint file <leader lf>
		vim.keymap.set("n", "<leader>lf", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
	config = function(_, opts)
		require("lint").linters_by_ft = opts.linters_by_ft
	end,
}

return { formatter, linter }
