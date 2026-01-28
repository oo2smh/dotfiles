local diag = vim.diagnostic
local global_search_replace
local open_root_file
local toggle_fullscreen
local fullscreen = false
local opts = { noremap = true, silent = true }

--******************************************************************
-- ACTIONS
--*******************************************************************
-- UNIVERSAL: text manipulation
------------------------------------------------------------------
-- GENERAL
keymap("n", "<leader>.",":w<cr>") -- save

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

-- synchronize insert with normal. QMK kybd shortcut
keymap("n", "<C-r>a", "i<C-r>a<esc>")
keymap("n", "<C-r>0", "i<C-r>0<esc>")

-- SELECTIONS
keymap("n", "<leader>v", "GVgg")
keymap("n", "<S-end>", "V")

-- SEARCH AND REPLACE (EXCHANGE)
------------------------------------------------------------
-- better * (*N) hackish, but works with flickering. This longer command doesn't flicker
keymap("n", "*",
  ":let @/='\\<'.expand('<cword>').'\\>'<CR>:set hlsearch<CR>",
  opts
)
-- (count)& to apply to line(s).
-- g& to apply to whole file. Or add % to the beginning to change whole file
-- *lr and leave the search term blank to change all selection
-- remove the g to only change the first occurrence
keymap( { "n", "v" }, "lee", ":s///g<Left><Left><Left>", { noremap = true, desc = "replace line/selection" })
keymap( { "n", "v" }, "les", "*:%s///g<Left><Left>", { noremap = true, desc = "replace * word" })
keymap({ "n", "v" }, "lep", function() global_search_replace() end, { noremap = true, desc = "replace project wide" })

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
keymap("n", "<leader>I", ":restart<cr>", { desc = "restart file" }) -- install
keymap("n", "<leader>i", ":source %<cr>", { desc = "source file" }) -- install

--*****************************************************************
-- NAVIGATION
--******************************************************************
-- OPEN CLOSE
keymap("n", "<leader>f", function()	toggle_fullscreen() end, { desc = "toggle fullscreen" })
keymap({ "n", "v" }, "<A-.>", "<cmd>:q!<cr>") -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap({ "n", "v" }, "<C-w>", "<cmd>:q!<cr>", { noremap = true, nowait = true }) -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap("t", "<Esc>", "<C-\\><C-n>:bd!<CR>", opts) --nnn.nvim opens in a terminal window..allows you to escape with 1 esc
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

-- PANES/TABS
keymap("n", "<A-n>", ":vsplit<CR>", opts) -- wide
keymap("n", "<A-h>", ":split<CR>", opts) -- ground
keymap({ "n", "v" }, "<A-t>", ":vsplit<cr>:term<cr>") --new terminal
keymap("n", "<A-a>", ":tabnew<cr>") --new tab
keymap("n", "<A-e>", "gt") --new tab
keymap({ "n", "v" }, "g'", "gt") -- put git/reference in tab 2

-- BUFFERS
keymap({ "n", "v" }, "<C-f>", "<C-w>w", opts)
keymap("i", "<C-f>", "<esc><C-w>w", opts)
keymap("t", "<C-f>", [[<C-\><C-n><C-w>w]], opts)

keymap({ "n", "v" }, "#", ":b#<CR>", opts)
keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")
keymap("t", "<A-Right>", [[<C-\><C-n>:bn<CR>]], opts)
keymap("t", "<A-Left>", [[<C-\><C-n>:bp<CR>]], opts)
keymap("n", "<A-r>", ":e #<cr>") -- open last closed

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
-- HELPER FNS
--*******************************************************************
global_search_replace = function()
	-- 1. Get the search term from the user
	local search_term = vim.fn.input("Search for (regex): ")
	if search_term == "" then
		print("Search term cannot be empty.")
		return
	end

	local replace_term = vim.fn.input("Replace with (literal): ")

	local escaped_search = vim.fn.escape(search_term, "\\/")
	local vimgrep_cmd = string.format("vimgrep /%s/j **/*", escaped_search)

	print("Searching project...")
	cmd(vimgrep_cmd)

	if vim.fn.getqflist({ title = true }).title == nil then
		print("No matches found in project.")
		return
	end

	local escaped_replace = vim.fn.escape(replace_term, "\\/")
	local cdo_cmd = string.format("cdo s/%s/%s/gc", escaped_search, escaped_replace)

	print("Starting replacement process. Press 'y' to confirm, 'n' to skip, or 'a' to replace all in current file.")
	cmd(cdo_cmd)

	print("Global search and replace finished.")
	cmd("cclose") -- Close the quickfix window when done
end

vim.api.nvim_create_user_command("GR", global_search_replace, {
	desc = "Project-wide Search and Replace with Confirmation",
})

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

