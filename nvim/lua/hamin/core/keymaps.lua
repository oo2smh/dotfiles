local keymap = vim.keymap.set
vim.g.mapleader = ' '

-- NETRW
keymap("n", "<leader>o", "<cmd>Ex<cr>")

-- QUIT
keymap("n", "<leader>q", "q<cmd>q<cr>")
keymap("n", "<leader>x", "<cmd>x<cr>")
keymap("n", "<leader>!", "<cmd>q!<cr>")

-- OTHER
keymap({ "n", "v" }, "<C-c>", "<ESC>")
keymap("n", "<leader>s", ":source<cr>")

-- NAVIGATION
keymap({ "n", "v" }, "[b", ":bp<cr>")
keymap({ "n", "v" }, "]b", ":bn<cr>")

-- SCROLL
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- SYSTEM CLIPBOARD
keymap({ "n", "v" }, "<leader>y", '"+y')
keymap({ "n", "v" }, "<leader>p", '"+p')

-- SURROUND 1 WORD
keymap("n", '<leader>s"', 'ciw""<ESC>P')
keymap("n", '<leader>s(', 'ciw()<ESC>P')
keymap("n", '<leader>s[', 'ciw[]<ESC>P')
keymap("n", '<leader>s{', 'ciw{}<ESC>P')
