return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"debugloop/telescope-undo.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.load_extension("fzf")
		telescope.load_extension("undo")

		telescope.setup({
			faults = {
				file_ignore_patterns = {
					"node_modules",
					"undodir",
					".git",
				},
				mappings = {
					i = {
						["<C-g>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist,
					},
					n = {
						["<C-g>"] = actions.close,
						["<C-q>"] = actions.smart_send_to_qflist,
					},
				},
			},
		})

		--key: telescope
		local keymap = vim.keymap.set
		keymap("n", "<leader>dh", "<cmd>Telescope diagnostics bufnr=0<cr>") -- diagnostics here
		keymap("n", "<leader>de", "<cmd>Telescope diagnostics<cr>") -- diagnostics everywhere
		keymap("n", "<leader>h", "<cmd>Telescope git_files<cr>") -- searces from the top of the git file
		keymap("n", "h", "<cmd>Telescope find_files<cr>") -- searces from the top of the git file
		keymap("n", "<A-h>", "<cmd>Telescope oldfiles<cr>") -- searces from the top of the git file
		keymap("n", "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>") --filter by function, variable, classes, etc
		keymap("n", "<leader>r", "<cmd>Telescope registers<cr>") --clipboards
		keymap("n", "<leader>u", "<cmd>Telescope undo<cr>") --history
		keymap("n", "<leader>t", "<cmd>TodoTelescope keywords=TODO,TEST<cr>")
		keymap("n", "<leader>b", "<cmd>TodoTelescope keywords=h<cr>") --beacon sections
		keymap("n", "<leader>f", "<cmd>TodoTelescope keywords=FIX,HACK,WARN<cr>") --beacon sections
	end,
}
