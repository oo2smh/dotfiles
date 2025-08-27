local keymap = vim.keymap.set

-- ****************************************************************************
-- ACTIONS
-- ****************************************************************************
-- SEARCH AND REPLACE
keymap("n", "*", ":let @/='\\<'.expand('<cword>').'\\>'<CR> :set hlsearch<CR>", { noremap = true, silent = true })
keymap({ "n", "v" }, "<localleader>r", "*:%s///g<Left><Left>", { noremap = true, silent = false })
keymap({ "n", "v" }, "<leader>rg", 'y:%s/<C-r>"//g<Left><Left>', { noremap = true, silent = false })
keymap({ "n", "v" }, "<leader>rl", ':s///g<Left><Left><Left>', { noremap = true, silent = false })

-- MISCELLANEOUS
keymap("n", "<leader>w", ":set wrap!<cr>")
keymap("n", "<leader>i", ":source %<cr>") -- install
keymap("n", "<leader>w", ":set wrap!<cr>")
keymap("v", "<leader>b", ":norm ")

-- QUICKFIX
keymap("n", "<F1>", ":cclose<CR>")
keymap("n", "<F2>", ":copen<CR>")
keymap("n", "<F3>", ":cprev<CR>")
keymap("n", "<F4>", ":cnext<CR>")

-- DIAGNOSTICS
keymap("n", "<localleader>l", vim.lsp.buf.references) -- linkages
keymap("n", "<localleader>i", vim.lsp.buf.hover)
keymap("n", "<localleader>d", vim.diagnostic.open_float)
keymap("n", "<localleader>i", vim.diagnostic.goto_prev)
keymap("n", "<localleader>e", vim.diagnostic.goto_next)

-- UNIVERSAL DELETE WORD back/forward
keymap("i", "<C-BS>", "<C-w>")
keymap("i", "<C-DEL>", "<C-o>dw")
keymap("n", "<C-DEL>", "dw")
keymap("n", "<DEL>", "x")
-- keymap("n", "<C-BS>", "db") -- this doesn't work

-- TAB TO INDENT
keymap({ "n", "v" }, "<C-t>", ">>", { noremap = true, silent = true })
keymap({ "n", "v" }, "<S-Tab>", "<<", { noremap = true, silent = true })
keymap("i", "<S-Tab>", "<C-d>", { noremap = true, silent = true })

-- CLIPBOARD
keymap({ "n", "v" }, "<leader>y", '"f') -- temp register
keymap({ "n", "v" }, "<leader>p", '"f') -- temp register
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "n", "v" }, "<C-v>", '"+p', { noremap = true })
keymap("i", "<C-v>", "<C-r>+") --paste in insert mode

-- ****************************************************************************
-- NAVIGATION
-- ****************************************************************************
-- OPEN CLOSE
keymap({ "n", "v" }, "<A-.>", "<cmd>:q!<cr>") -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

--OPEN
keymap("n", "<A-g>", ":vsplit<CR>", { noremap = true, silent = true }) -- new pane
keymap("n", "<A-t>", ":tabnew<cr>")                                    --new tab
keymap({ "n", "v" }, "<A-f>", ":vsplit<cr>:term<cr>")                  --new terminal

-- PANES BUFFERS LISTS
keymap({ "n", "v" }, "<Tab>", "<C-w>w", { noremap = true, silent = true })

-- BUFFERS
keymap({ "n", "v" }, "<C-S-right>", ":b#<cr>")
keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")

-- SCROLL
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap({ "n", "v" }, "<C-y>", "<C-i>zz")
keymap({ "n", "v" }, "<C-o>", "<C-o>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
