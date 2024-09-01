local keymap = vim.keymap.set

-- MD MACROS
keymap("n", "<leader>mdd", "i<details><summary> </summary>\r<CR></details><ESC>kkEa")
keymap("n", "<leader>mdh", "i<!--==================--><CR><CR><!--==================--><ESC>ki# ")
