local diag = vim.diagnostic
local opts = { noremap = true, silent = true }
local argon = require("argslist")
local H = require("helper_fns")

--*******************************************************************
-- PLUGINS
--*******************************************************************
-- NNN
keymap("n", "hn", "<cmd>NnnPicker %:p:h<CR>")

-- MINI
-- mini.snippets keymaps (in init.lua) didn't work if moved here (c-t, s/tab)
require("mini.splitjoin").setup({mappings = {toggle = "mo"}})
require("mini.operators").setup({exchange = {prefix = "go"}})
keymap({"n", "v"}, "!", function() cmd("norm [h") end, { desc = "prev hunk" })
keymap({"n", "v"}, "-", function() cmd("norm ]h") end, { desc = "next hunk" })

-- MINI.PICK
local pick = "<cmd>Pick "
require("mini.pick").setup({ mappings = {toggle_preview = "<C-f>", scroll_down = "<C-left>", scroll_up = "<C-right>" }})
keymap("n", "ht",  pick .. "files<cr>", { desc = "files" })
keymap("n", "hT",  pick .. "git_files<cr>", { desc = "git files" })
keymap("n", "ho",  pick .. "buffers<cr>", { desc = "open buffers" })
keymap("n", "hs",  pick .. "grep_live<cr>", { desc = "string search" })
keymap("n", "hh",  pick .. "help<cr>", { desc = "help manuals" })
keymap("n", "hd",  pick .. "diagnostic<cr>", { desc = "project diagnostic" })
keymap("n", "hr",  pick .. "registers<cr>", { desc = "registers" })
keymap("n", "hm",  pick .. "marks<cr>", { desc = "marks" })
keymap("n", "hu", function() require("mini.diff").toggle_overlay(0) end, { desc = "MiniDiff: toggle diff overlay" })
keymap("n", "h,", function() H.check_health() end, { noremap = true, desc = "Pick Healthcheck" })

keymap("n", "hab", pick .. "git_branches<cr>", { desc = "git branch commits" })
keymap("n", "haw", function() H.git_branch_switch() end, { desc = "git branch switch" })
keymap("n", "hai", pick .. "git_commits<cr>", { desc = "git commits" })
keymap("n", "han", pick .. "git_hunks<cr>", { desc = "git hunks" })

-- Fugitive
keymap("n", "hg", ":vertical G | vertical resize 60<CR>", { desc = "git status" }) --top overview
keymap("n", "haf", ":G blame -w -s<cr>", { desc = "git blame" }) -- fault
keymap("n", "hal", ":Git log<cr>", { desc = "git log" }) -- use this to see commits and rebase
keymap("n", "hat", ":G stash list<CR>", { desc = "stash show" })
-- don't use Gvdiffsplit! Downloads a :fugitive folder and messes up :Git command

-- HIGHLIGHTER
keymap("n", "h<cr>", ":Hi +<cr>")
keymap("n", "t<esc>", ":Hi -<cr>")
keymap("n", "t<bs>", ":Hi clear<cr>")
keymap("n", "#", ":Hi }<cr>zz")
keymap("n", "|", ":Hi {<cr>zz")
keymap("n", "hih", ":Hi load <tab><cr>")
keymap("n", "<leader>hs", ":Hi save <tab><cr>")
keymap("n", "<leader>hl", ":Hi ls<cr>")

-- ARGON: ARGSLIST
for i = 1, 6 do
  keymap({ "n", "v" }, "'" .. i, function()
    argon.replace_arg_at_idx(i)
  end, { desc = "Arglist: Replace at " .. i })

  keymap("n", ("<A-%d>"):format(i), function()
    cmd(i .. "argument")
    argon.echo_argslist()
  end, { desc = "Arglist: Jump to " .. i })
end

keymap("n", "hia",        argon.load_args,        { desc = "Arglist: Load" })
keymap("n", "<leader>as", argon.save_args,        { desc = "Arglist: Save" })
keymap("n", "<leader>aa", argon.add_buffer_to_end,{ desc = "Arglist: Add current" })
keymap("n", "<leader>ai", argon.echo_argslist,    { desc = "Arglist: Show" })
keymap("n", "<leader>ad", ":argdelete %<CR>", { desc = "Arglist: Delete current" })
keymap("n", "<leader>a*", ":argdelete *<CR>", { desc = "Arglist: Clear all" })

-- QUICKER
require("quicker").setup({
    keys = { {
      ">",
      function()
        require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
      end,
      desc = "Expand quickfix context",
    },
    {
      "<",
      function()
        require("quicker").collapse()
      end,
      desc = "Collapse quickfix context",
    },
  },
})

--******************************************************************
-- ACTIONS
--*******************************************************************
-- GENERAL
keymap("n", "hN", ":Ex<Cr>")
keymap("c", "<Down>", "<C-n>", { noremap = true, silent = true })
keymap("c", "<Up>",   "<C-p>", { noremap = true, silent = true })
keymap("n", "<leader>w", ":set wrap!<cr>", { desc = "set wrap" })
keymap("n", "<leader>I", "<cmd>restart<cr>", { desc = "restart file" })
keymap("n", "<leader>i", ":source %<cr>", { desc = "source file" }) -- install
keymap("n", "l'", "gUU", { noremap = true, silent = true })

-- SESSION
keymap("n", "his",   ":so Session.vim<cr>", { noremap = true })
keymap("n", "<leader>ss",   ":mks!<cr>", { noremap = true })

--DELETE
-- ctrl h is how tmux/shell understands ctrl bspc
keymap({"i", "c"}, "<C-H>", "<C-w>")
keymap({"i", "c"}, "<C-BS>", "<C-w>")
keymap("n", "<C-H>", "<C-w>w")
keymap({"i", "c"}, "<S-End>", "<esc>v<end>dO")

-- TAB TO INDENT
-- <Tab> is represented as <C-i> in terminal/tmux. Remap. Use Ctl-m for loc jumping
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
  opts)

-- alter (replace (element, inclusive), global (delete, yank, fall))
keymap( { "n", "v" }, "lae", ":s///g<Left><Left><Left>", { noremap = true, desc = "replace line/selection" })
keymap( { "n", "v" }, "lai", ":%s///g<Left><Left><Left>", { noremap = true, desc = "replace in buffer" })
keymap( { "n", "v" }, "lay", ":g//y A<Left><Left><Left><Left>", { noremap = true, desc = "global yank" })
keymap( { "n", "v" }, "lad", ":g//d<Left><Left>", { noremap = true, desc = "global delete" })
keymap( { "n", "v" }, "lah", ":g//m0<Left><Left><Left>", { noremap = true, desc = "move to highest" })
keymap( { "n", "v" }, "lal", ":g//m$<Left><Left><Left>", { noremap = true, desc = "move to lowest" })

-- DIAGNOSTICS
--------------------------------------------------------------------
local error_only_opts  = { severity = { min = diag.severity.ERROR }}

keymap("n", "ld", diag.open_float, { desc = "lsp diagnostic info" })
keymap("n", "ly", function() diag.goto_prev(error_only_opts) cmd("norm zz") end, { desc = "Prev Error Diagnostic" })
keymap("n", "lo", function() diag.goto_next(error_only_opts) cmd("norm zz") end, { desc = "Next Error Diagnostic" })
keymap("n", "li", function() diag.goto_prev() cmd("norm zz") end, { desc = "Prev Diagnostic" })
keymap("n", "le", function() diag.goto_next() cmd("norm zz") end, { desc = "Next Diagnostic" })

--*****************************************************************
-- NAVIGATION
--******************************************************************
-- RANDOM
keymap({"n", "v"}, "h'", "`", { desc = "grave" })
keymap("i", "gM", "<ESC>gM")

-- OPEN CLOSE
keymap("n", "<leader>f", function()	H.toggle_fullscreen() end, { desc = "toggle fullscreen" })
keymap({ "n", "v" }, "<C-w>", "<cmd>:q!<cr>", { noremap = true, nowait = true }) -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap("t", "<Esc>", "<C-\\><C-n>:bd!<CR>", opts) --nnn.nvim opens in a terminal window..allows you to escape with 1 esc
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

-- PANES/TABS
keymap("n", "<A-n>", ":vsplit<CR>", opts)
keymap("n", "<A-N>", ":split<CR>", opts)
keymap({ "n", "v" }, "<A-a>", ":vsplit<cr>:term<cr>")
keymap("n", "<A-l>", ":tabnew<cr>")
keymap({ "n", "v" }, "g'", "gt")

-- BUFFERS
keymap({ "n", "v" }, "<C-f>", ":b#<CR>", opts)
keymap({ "n", "v" }, "<C-h>", "<C-w>w", opts)
keymap({"n", "v"}, "<C-BS>", "<C-w>w", opts)
keymap("t", "<C-h>", [[<C-\><C-n><C-w>w]], opts)

keymap({ "n", "v" }, "<A-right>", ":bn<cr>")
keymap({ "n", "v" }, "<A-left>", ":bp<cr>")
keymap("t", "<A-Right>", [[<C-\><C-n>:bn<CR>]], opts)
keymap("t", "<A-Left>", [[<C-\><C-n>:bp<CR>]], opts)

-- SCROLL AND CENTER
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "<C-m>", "<C-i>")
keymap("n", "<ScrollWheelUp>", "5kzz")
keymap("n", "<ScrollWheelDown>", "5jzz")
keymap("n", "<C-t>", "g;zz") -- time bound
keymap("n", "<C-n>", "g,zz") -- newer change
keymap("n", "<C-o>", "<C-o>zz")
keymap("n", "<C-m>", "<C-i>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- QUICKFIX LIST
keymap("n", "<leader>l", function() require("quicker").toggle() end, { desc = "Toggle quickfix", })
keymap("n", "<leader>qa", ":vimgrep  **/*<C-left><left>") -- all
keymap("n", "<leader>qb", ":vimgrep  %<C-left><left>") -- buffer
keymap("n", "<F2>", ":cp<cr>")
keymap("n", "<F3>", ":cn<cr>")

-- OPEN KEY FILES
keymap("n", "<leader>r", function()	H.open_root_file("README.md") end, { desc = "README.md" })
keymap("n", "<leader>n", "<cmd>e ~/Doc/notes/tmp/_notes.md<cr>" , { desc = "notes.md" })
keymap("n", "<leader>t", ":e ~/Doc/notes/tmp/_tmp.md<CR>", { desc = "temp.md" })
keymap("n", "<leader>k", ":e ~/Doc/notes/etc/keys.md<CR>", { desc = "Nvim keymaps" })
