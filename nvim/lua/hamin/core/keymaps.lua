local keymap = vim.keymap.set
vim.g.mapleader = ' '

-- NETRW
keymap("n", "<leader>e", "<cmd>Ex<cr>")

-- QUIT
keymap("n", "<leader>q", "<cmd>q<cr>")
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
keymap("n", "<leader>y", '"+y')
keymap("n", "<leader>p", '"+p')

-- SURROUND 1 WORD
keymap("n", '<leader>s"', 'ciw""<ESC>P')
keymap("n", '<leader>s(', 'ciw()<ESC>P')
keymap("n", '<leader>s[', 'ciw[]<ESC>P')
keymap("n", '<leader>s{', 'ciw{}<ESC>P')

-- MD MACROS
keymap("n", "<leader>mdd", "i<details><summary> </summary>\r\r</details><ESC>kkEa")
keymap("n", "<leader>mdh", "i<!--==================--><CR><CR><!--==================--><ESC>ki# ")
-- \r = <CR>
