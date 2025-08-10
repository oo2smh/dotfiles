local keymap = vim.keymap.set

-- ****************************************************************************
-- SEARCH AND REPLACE
-- ****************************************************************************
keymap("n", "*", ":let @/='\\<'.expand('<cword>').'\\>'<CR> :set hlsearch<CR>", { noremap = true, silent = true })
keymap({ "n", "v" }, "<localleader>r", "*:%s///g<Left><Left>", { noremap = true, silent = false })
keymap({ "n", "v" }, "<leader>rg", 'y:%s/<C-r>"//g<Left><Left>', { noremap = true, silent = false })
keymap({ "n", "v" }, "<leader>rl", ':s///g<Left><Left><Left>', { noremap = true, silent = false })

-- MISCELLANEOUS
-- keymap("n", "<C-i>", "<tab>") -- default behavior
keymap("n", "<leader>w", ":set wrap!<cr>")
keymap("n", "<leader>i", ":source %<cr>") -- install
keymap("n", "<leader>w", ":set wrap!<cr>")

keymap("n", "<leader>t", ":e ~/Doc/notes/tmp/_todo.md<cr>")
keymap("n", "<C-t>", function()
  local readme_path = vim.fn.getcwd() .. "/README.md"
  vim.cmd("edit " .. readme_path)
end, { desc = "Open README.md in cwd" })

-- DIAGNOSTICS
keymap("n", "<localleader>f", vim.lsp.buf.format)      -- format
keymap("n", "<localleader>D", vim.lsp.buf.declaration) --
keymap("n", "<localleader>l", vim.lsp.buf.references)  -- linkages

keymap("n", "<localleader>i", vim.lsp.buf.hover)
keymap("n", "<localleader>d", vim.diagnostic.open_float)
keymap("n", "<localleader>p", vim.diagnostic.goto_prev)
keymap("n", "<localleader>n", vim.diagnostic.goto_next)

-- UNIVERSAL DELETE WORD
keymap("i", "<C-BS>", "<C-w>")
keymap("n", "<C-BS>", "diw")
keymap("v", "<C-BS>", "iwd")

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
keymap({ "n", "v", "i" }, "<A-.>", "<cmd>:q!<cr>") -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap({ "n", "v", "i" }, "<C-g>", ":bd<cr>", { silent = true })

--OPEN
keymap("n", "<A-g>", ":vsplit<CR>", { noremap = true, silent = true }) -- new pane
keymap("n", "<A-t>", ":tabnew<cr>")                                    --new tab
keymap({ "n", "v", "i" }, "<A-f>", ":vsplit<cr>:term<cr>")             --new terminal

-- PANES BUFFERS LISTS
keymap({ "n", "v" }, "<Tab>", "<C-w>w", { noremap = true, silent = true })

-- BUFFERS
keymap({ "n", "v" }, "<C-S-right>", ":b#<cr>")
keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")

-- SCROLL
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
