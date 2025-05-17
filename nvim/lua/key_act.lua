local keymap = vim.keymap.set

-- GENERAL
keymap("n", "<leader>i", ":source %<cr>")
keymap("n", "<leader>y", ':let @+ = expand("%:p")<cr>')

-- DIAGNOSTICS
keymap("n", "<localleader>s", vim.lsp.buf.declaration)
keymap("n", "<localleader>u", vim.lsp.buf.references)
keymap("n", "<A-n>", ":lnext<cr>")
keymap("n", "<A-p>", ":lprev<cr>")

keymap("n", "<localleader>a", vim.lsp.buf.hover)
keymap("n", "<localleader>r", vim.lsp.buf.rename)
keymap("n", "<localleader>d", vim.diagnostic.open_float)
keymap("n", "<localleader>p", vim.diagnostic.goto_prev)
keymap("n", "<localleader>n", vim.diagnostic.goto_next)

-- UNIVERSAL DELETE WORD
keymap("i", "<C-BS>", "<C-w>")
keymap("n", "<C-BS>", "diw")
keymap("v", "<C-BS>", "iwd")

-- MOVE LINES UP AND DOWN
keymap("v", "<C-down>", ":m '>+1<CR>gv=gv")
keymap("v", "<C-up>", ':<C-u>exec "\'<,\'>move " . (line("\'<") - 2)<CR>gv=gv')
keymap("n", "<C-down>", ":m .+1<CR>==")
keymap("n", "<C-up>", ":m .-2<CR>==")

-- SYSTEM CLIPBOARD
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "n", "v" }, "<C-v>", '"+p', { noremap = true })
keymap("i", "<C-v>", "<C-r>+") --paste in insert mode

-- SURROUND 1 WORD
keymap("n", '<leader>"', 'ciW""<ESC>P')
keymap("n", "<leader>(", "ciW()<ESC>P")
keymap("n", "<leader>[", "ciW[]<ESC>P")
keymap("n", "<leader>{", "ciW{}<ESC>P")
keymap("n", "<leader>`", "ciW``<ESC>P")

keymap("v", '<leader>"', 'c""<ESC>P')
keymap("v", "<leader>(", "c()<ESC>P")
keymap("v", "<leader>[", "c[]<ESC>P")
keymap("v", "<leader>{", "c{}<ESC>P")
keymap("v", "<leader>`", "c``<ESC>P")
