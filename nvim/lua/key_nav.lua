local keymap = vim.keymap.set

---------------------------------------------------------------
--NOTE: Navigation consists of windows management. Opening, moving, resizing, scrolling, etc
-- tab = external hypr window viewport. can contain 1+ panes
-- pane/split = pane can contain many open buffers
-- :q closes the pane. :bd closes the individual buffer (also the pane if it's the last buffer)
-- I chose CTRL G to close the buffer to work w/ nnn's default quit keymap
------------------------------------------------------------------

-- ARROW KEYS
keymap({ "n", "v" }, "<up>", "g<up>")
keymap({ "n", "v" }, "<down>", "g<down>")
keymap({ "n", "v" }, "<END>", "g<END>")
keymap({ "n", "v" }, "<HOME>", "g<HOME>")

--CLOSE
keymap({ "n", "v" }, "<A-.>", "<cmd>:q!<cr>") -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap("i", "<A-.>", "<cmd>:q!<cr>")
keymap("i", "<C-g>", "<ESC><cmd>:bd<cr>", { silent = true }) -- buffer/view close
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

--OPEN
keymap("n", "<A-g>", ":vsplit<CR>", { noremap = true, silent = true }) -- new pane
keymap("n", "<A-t>", ":tabnew<cr>") --new tab
keymap({ "n", "v", "i" }, "<A-f>", ":vsplit<cr>:term<cr>") --new terminal

-- TERMINAL SPECIFIC
local exit_term = "<C-\\><C-n><ESC>"
keymap("t", "<ESC>", exit_term, { noremap = true, silent = true })
keymap("t", "<C-g>", exit_term .. ":bd<cr>", { noremap = true, silent = true })
keymap("t", "<A-.>", exit_term .. ":q<cr>", { noremap = true, silent = true })
keymap("t", "<A-Tab>", exit_term .. "<C-w>w", { noremap = true, silent = true })
keymap("t", "<A-d>", exit_term .. ":vertical resize -20%<CR>", { silent = true })
keymap("t", "<A-l>", exit_term .. ":vertical resize +20%<CR>", { silent = true })
keymap("t", "<A-left>", exit_term .. ":bp<cr>", { silent = true })
keymap("n", exit_term .. "<A-1>", ":argument 1<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-2>", ":argument 2<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-3>", ":argument 3<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-4>", ":argument 4<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-5>", ":argument 5<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-6>", ":argument 6<cr>:lua EchoArglist()<cr>")

--------------------------------
-- PANES, BUFFERS, QF LIST
--------------------------------
-- PANES
keymap({ "n", "v" }, "<Tab>", "<C-w>w", { noremap = true, silent = true })
keymap({ "n", "v" }, "<A-d>", ":vertical resize -20<CR>", { silent = true })
keymap({ "n", "v" }, "<A-p>", ":horizontal resize -20<CR>", { silent = true })
keymap({ "n", "v" }, "<A-_>", ":horizontal resize +20<CR>", { silent = true })
keymap({ "n", "v" }, "<A-l>", ":vertical resize +20<CR>", { silent = true })
keymap({ "n", "v" }, "<A-m>", "<C-w>h", { silent = true })
keymap({ "n", "v" }, "<A-w>", "<C-w>l", { silent = true })

-- use the leftmost pane to determine the movement.Only the leftmost pane will resize

-- BUFFERS
keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")

-- SCROLL
-- ctrl d for down ctrl t for top. all in one hand
keymap({ "n", "v" }, "<C-t>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- QUICKFIX
keymap({ "n", "v" }, "<F10>", ":TodoLocList<cr>", { silent = true })
keymap({ "n", "v" }, "<F1>", ":copen<cr>", { silent = true })
keymap({ "n", "v" }, "<F2>", ":cprev<cr>", { silent = true })
keymap({ "n", "v" }, "<F3>", ":cnext<cr>", { silent = true })
keymap("n", "<F4>", function()
	vim.fn.setqflist({}, "r")
end, { desc = "Clear quickfix list" })
