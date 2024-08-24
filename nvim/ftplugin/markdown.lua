local keymap = vim.keymap.set

-- MD MACROS
keymap("n", "<leader>mdd", "i<details><summary> </summary>\r\r</details><ESC>kkEa")
keymap("n", "<leader>mdh", "i<!--==================--><CR><CR><!--==================--><ESC>ki# ")
