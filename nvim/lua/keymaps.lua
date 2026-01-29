local diag = vim.diagnostic
local open_root_file
local toggle_fullscreen
local fullscreen = false
local opts = { noremap = true, silent = true }
local pick = "<cmd>Pick "
local extra = require("mini.extra")

--*******************************************************************
-- PLUGINS
--*******************************************************************
-- NNN
keymap("n", "hn", "<cmd>NnnPicker %:p:h<CR>")

-- MINI PICK
keymap("n", "ht",  pick .. "files<cr>", { desc = "files" })
keymap("n", "ho",  pick .. "buffers<cr>", { desc = "open buffers" })
keymap("n", "hs",  pick .. "grep_live<cr>", { desc = "string search" })
keymap("n", "hh",  pick .. "help<cr>", { desc = "help manuals" })
keymap("n", "hd",  pick .. "diagnostic<cr>", { desc = "project diagnostic" })
keymap("n", "hr",  pick .. "registers<cr>", { desc = "registers" })
keymap("n", "hu", function() require("mini.diff").toggle_overlay(0) end, { desc = "MiniDiff: toggle diff overlay" })

-- GIT
keymap("n", "hg", ":vertical G | vertical resize 60<CR>", { desc = "git status" }) --top overview
keymap("n", "hai", pick .. "git_commits<cr>", { desc = "git commits" })
keymap("n", "han", pick .. "git_hunks<cr>", { desc = "git commits" })
keymap("n", "haf", ":G blame", { desc = "git blame" }) -- fault
keymap("n", "har", ":Git log<cr>", { desc = "git blame" }) -- use this to see commits and rebase
keymap("n", "has", ":G stash list<CR>", { desc = "stash show" })
keymap("n", "hap", ":Gvdiffsplit HEAD~1<cr>", { desc = "git diff" }) -- index to previous commit
keymap("n", "had", ":Gvdiffsplit", { desc = "merge conflicts" }) -- index to working

-- HIGHLIGHTER
keymap("n", "h<cr>", ":Hi +<cr>")
keymap("n", "t<esc>", ":Hi -<cr>")
keymap("n", "t<bs>", ":Hi clear<cr>")
keymap("n", "`", ":Hi }<cr>zz")
keymap("n", "|", ":Hi {<cr>zz")
keymap("n", "hih", ":Hi load <tab><cr>")
keymap("n", "his", ":Hi save <tab><cr>")
keymap("n", "hil", ":Hi ls<cr>")

--******************************************************************
-- ACTIONS
--*******************************************************************
-- UNIVERSAL: text manipulation
------------------------------------------------------------------
-- GENERAL
keymap("n", "<leader>.",":w<cr>") -- save
keymap("c", "<Down>", "<C-n>", { noremap = true, silent = true })
keymap("c", "<Up>",   "<C-p>", { noremap = true, silent = true })


--DELETE
-- ctrl h is how tmux/shell understands ctrl bspc
keymap({"n", "v"}, "<C-H>", "<Nop>", { noremap = true, silent = true })
keymap({"i", "c"}, "<C-H>", "<C-w>")
keymap({"i", "c"}, "<C-BS>", "<C-w>")
keymap({"i", "c"}, "<S-End>", "<esc>v<end>dO")

-- NETRWC (Use to create and delete files. Use nnn for everything else)
keymap("n", "hN", ":Ex<Cr>")

-- TAB TO INDENT
-- <Tab> is represented as Ctrl i. Remap. Use Ctl-m for loc jumping
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<Tab>", ">", opts)
keymap("n", "<S-Tab>", "<<", opts)
keymap("v", "<S-Tab>", "<", opts)
keymap("i", "<S-Tab>", "<C-d>", opts)

-- CLIPBOARD (3 clipboards: sys(+), yank(0), custom(a))
keymap({ "n", "v" }, "<leader>y", '"ay', { desc = "copy to temp" }) -- temp register
keymap({ "n", "v" }, "<leader>p", '"ap', { desc = "paste from temp" }) -- temp register
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "n", "v" }, "<C-v>", '"+p', opts )
keymap("i", "<C-v>", "<C-r>+") --paste in insert mode

-- synchronize insert paste with normal. QMK kybd shortcut
keymap("n", "<C-r>a", "i<C-r>a<esc>")
keymap("n", "<C-r>0", "i<C-r>0<esc>")

-- SELECTIONS
keymap("n", "<leader>v", "GVgg")
keymap("n", "<S-end>", "V")

-- SEARCH AND REPLACE (EXCHANGE)
------------------------------------------------------------
-- better * (*N) hackish, but works with flickering. This longer command doesn't flicker
keymap({"n", "v"}, "*",
  ":let @/='\\<'.expand('<cword>').'\\>'<CR>:set hlsearch<CR>",
  opts
)
keymap( { "n", "v" }, "lee", ":s///g<Left><Left><Left>", { noremap = true, desc = "replace line/selection" })
keymap( { "n", "v" }, "lea", ":%s///g<Left><Left><Left>", { noremap = true, desc = "replace line/selection" })

-- DIAGNOSTICS
--------------------------------------------------------------------
local error_only_opts  = { severity = { min = diag.severity.ERROR }}

keymap("n", "ld", diag.open_float, { desc = "lsp diagnostic info" })
keymap("n", "h!", function() diag.goto_prev(error_only_opts) end, { desc = "Previous Error Diagnostic" })
keymap("n", "!", function() diag.goto_next(error_only_opts) end, { desc = "Next Error Diagnostic" })
keymap("n", "-", function() diag.goto_next() end, { desc = "Next Diagnostic" })
keymap("n", "+", function() diag.goto_prev() end, { desc = "Next Diagnostic" })

-- MISCELLANEOUS
------------------------------------------------------------------
keymap("i", "gM", "<ESC>gM")
keymap("n", "<leader>,", "VgU", { desc = "capitalize line" })
keymap("n", "<leader>$", ":DBUIToggle<cr>", { desc = "DBUI toggle" })
keymap("n", "<leader>w", ":set wrap!<cr>", { desc = "set wrap" })
keymap("n", "<leader>I", "<cmd>restart<cr>", { desc = "restart file" })
keymap("n", "<leader>i", ":source %<cr>", { desc = "source file" }) -- install

--*****************************************************************
-- NAVIGATION
--******************************************************************
-- OPEN CLOSE
keymap("n", "<leader>f", function()	toggle_fullscreen() end, { desc = "toggle fullscreen" })
keymap({ "n", "v" }, "<C-w>", "<cmd>:q!<cr>", { noremap = true, nowait = true }) -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap("t", "<Esc>", "<C-\\><C-n>:bd!<CR>", opts) --nnn.nvim opens in a terminal window..allows you to escape with 1 esc
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

-- PANES/TABS
keymap("n", "<A-n>", ":vsplit<CR>", opts)
keymap("n", "<A-h>", ":split<CR>", opts)
keymap({ "n", "v" }, "<A-t>", ":vsplit<cr>:term<cr>")
keymap("n", "<A-o>", ":tabnew<cr>")
keymap("n", "<A-a>", "gt")
keymap({ "n", "v" }, "g'", "gt")

-- BUFFERS
keymap({ "n", "v" }, "#", ":b#<CR>", opts)
keymap({ "n", "v" }, "<C-f>", "<C-w>w", opts)
keymap("i", "<C-f>", "<esc><C-w>w", opts)
keymap("t", "<C-f>", [[<C-\><C-n><C-w>w]], opts)

keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")
keymap("t", "<A-Right>", [[<C-\><C-n>:bn<CR>]], opts)
keymap("t", "<A-Left>", [[<C-\><C-n>:bp<CR>]], opts)
keymap("n", "<A-l>", ":e #<cr>") -- open last closed

-- SCROLL AND CENTER
keymap("n", "<C-m>", "<C-i>")
keymap("n", "<ScrollWheelUp>", "5kzz")
keymap("n", "<ScrollWheelDown>", "5jzz")
keymap("n", "<C-t>", "g;zz") -- time bound
keymap("n", "<C-n>", "g,zz") -- new change
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap({ "n", "v" }, "<C-o>", "<C-o>zz")
keymap({ "n", "v" }, "<C-m>", "<C-i>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- QUICKFIX LIST
keymap("n", "<F2>", "[q")
keymap("n", "<F3>", "]q")

-- OPEN KEY FILES
keymap("n", "<leader>r", function()	open_root_file("README.md") end, { desc = "README.md" })
keymap("n", "<leader>n", "<cmd>e ~/Doc/notes/tmp/_notes.md<cr>" , { desc = "notes.md" })
keymap("n", "<leader>t", ":e ~/Doc/notes/tmp/_tmp.md<CR>", { desc = "temp.md" })
keymap("n", "<leader>k", ":e ~/Doc/notes/etc/keys.md<CR>", { desc = "Nvim keymaps" })

--*******************************************************************
-- HELPER_FNS
--*******************************************************************
toggle_fullscreen = function()
  if not fullscreen then
    cmd("wincmd |")
    cmd("wincmd _")
  else
    cmd("wincmd =")
  end
  fullscreen = not fullscreen
end

open_root_file = function(filename)
  local git_dir = vim.fn.finddir(".git", ".;")

	if git_dir == "" then
		vim.notify(filename .. " doesn't exist in the git project", vim.log.levels.WARN)
		return
	end
	-- Strip off the /.git part to get the actual project root
	local root_path = vim.fn.fnamemodify(git_dir, ":h")
	local file_path = root_path .. "/" .. filename

	if vim.fn.filereadable(file_path) == 0 then
		vim.notify(filename .. " doesn't exist in the project root", vim.log.levels.WARN)
		return
	end

	cmd("edit " .. vim.fn.fnameescape(file_path))
end

