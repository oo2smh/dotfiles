return {
	{
		"NeogitOrg/neogit",
		lazy = false,
		dependencies = {
			"sindrets/diffview.nvim",
		},
		config = true,
		vim.keymap.set("n", "<leader>g", ":Neogit<CR>"),
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "-" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
		-- key: git keys
		keys = {
			{ "<leader>gh", ":Gitsigns preview_hunk<CR>" },
			{ "<leader>gw", ":G blame<CR>" },
		},
	},
}
