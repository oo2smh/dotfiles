local keymap = vim.keymap.set
keymap("n", "<leader>*", "<cmd>!python %<cr>")
keymap("n", "<C-#>", "<cmd>!pytest %<cr>")
