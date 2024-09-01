local keymap = vim.keymap.set
vim.g.mapleader = ' '

-- NETRW
keymap("n", "<leader>o", "<cmd>Ex<cr>")

-- QUIT
keymap("n", "<leader>q", "<cmd>q<cr>")
keymap("n", "<leader>x", "<cmd>x<cr>")
keymap("n", "<leader>!", "<cmd>q!<cr>")
keymap("n", "<leader><leader>s", ":source %<cr>")

-- OTHER
keymap({ "n", "v" }, "<C-c>", "<ESC>")

-- NAVIGATION
keymap({ "n", "v" }, "<leader>bk", ":bp<cr>")
keymap({ "n", "v" }, "<leader>bj", ":bn<cr>")
keymap({ "n", "v" }, "<leader>bd", ":bdelete<cr>")

-- KEYMAPS
keymap({ "n", "v" }, "<leader>k", ":nmap <leader><cr>")

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
