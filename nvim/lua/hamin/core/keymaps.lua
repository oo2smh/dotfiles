local keymap = vim.keymap.set
vim.g.mapleader = ' '

-- NETRW
keymap("n", "<leader>o", "<cmd>Ex<cr>")
keymap("n", "<leader>s", ":source %<cr>")

-- OTHER
keymap({ "n", "v" }, "<C-c>", "<ESC>")
keymap("i", "<C-BS>", "<C-W>")
keymap("i", "<C-H>", "<C-W>")

-- NAVIGATION
keymap({ "n", "v" }, "<leader>bk", ":bp<cr>")
keymap({ "n", "v" }, "<leader>bj", ":bn<cr>")

-- SCROLL
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- SYSTEM CLIPBOARD
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap({ "n", "v" }, "<leader>p", '"+p')

-- SURROUND 1 WORD
keymap("n", '<leader>s"', 'ciW""<ESC>P')
keymap("n", '<leader>s(', 'ciW()<ESC>P')
keymap("n", '<leader>s[', 'ciW[]<ESC>P')
keymap("n", '<leader>s{', 'ciW{}<ESC>P')
keymap("n", '<leader>s`', 'ciW``<ESC>P')

keymap("v", '<leader>s"', 'c""<ESC>P')
keymap("v", '<leader>s(', 'c()<ESC>P')
keymap("v", '<leader>s[', 'c[]<ESC>P')
keymap("v", '<leader>s{', 'c{}<ESC>P')
keymap("v", '<leader>s`', 'c``<ESC>P')
