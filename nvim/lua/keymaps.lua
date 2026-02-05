local diag = vim.diagnostic
local opts = {silent = true, noremap = true}
local argon = require("argslist")
local H = require("helper_fns")
local ai = require("mini.ai")

--*******************************************************************
-- PLUGINS
--*******************************************************************
-- RUN CODE (markdown)
keymap("v", "m'p", ":w !python")
keymap("v", "m'j", ":w !node")
keymap("v", "m'g", ":w !go run .")

-- NNN
keymap("n", "hn", "<cmd>NnnPicker %:p:h<CR>")

-- MINI
-- mini.snippets keymaps (in init.lua) didn't work if moved here (c-t, s/tab)
-- use gH to reset Hunk (only use on modified/deleted hunks NOT added)
-- <c-spc> to show mini.completion in insert mode

require("mini.splitjoin").setup({mappings = {toggle = "mo"}})
require("mini.operators").setup({exchange = {prefix = "me"}, replace = {prefix = "ms"}}) -- exchange, substitute
keymap({"n", "v"}, "!", function() cmd("norm [hzz") end, { desc = "prev hunk" })
keymap({"n", "v"}, "-", function() cmd("norm ]hzz") end, { desc = "next hunk" })
ai.setup({
  custom_textobjects = {
    d = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
    o = ai.gen_spec.treesitter({ a = '@loop.outer', i = '@loop.inner' }),
    c = ai.gen_spec.treesitter({ a = '@conditional.outer', i = '@conditional.inner' }),
    m = ai.gen_spec.treesitter({ a = '@comments.outer', i = '@comments.inner' }),
  },
})

-- MINI.PICK
local pick = "<cmd>Pick "
require("mini.pick").setup({ mappings = {toggle_preview = "<C-f>", scroll_down = "<C-left>", scroll_up = "<C-right>" }})
keymap("n", "hc",  pick .. "colorschemes<cr>", { desc = "files" })
keymap("n", "ht",  pick .. "files<cr>", { desc = "files" })
keymap("n", "ho",  pick .. "buffers<cr>", { desc = "open buffers" })
keymap("n", "hs",  pick .. "grep_live<cr>", { desc = "string search" })
keymap("n", "hh",  pick .. "help<cr>", { desc = "help manuals" })
keymap("n", "hd",  pick .. "diagnostic<cr>", { desc = "project diagnostic" })
keymap("n", "hy",  pick .. "registers<cr>", { desc = "yanked registers" })
keymap("n", "hm",  pick .. "marks<cr>", { desc = "marks" })
keymap("n", "hp", function() require("mini.diff").toggle_overlay(0) end, { desc = "MiniDiff: toggle diff overlay" })
keymap("n", "h,", function() H.check_health() end, { noremap = true, nowait = true, desc = "Pick Healthcheck" })
keymap("n", "hab", pick .. "git_branches<cr>", { desc = "git branch commits" })
keymap("n", "haw", function() H.git_branch_switch() end, { desc = "git branch switch" })
keymap("n", "hai", pick .. "git_commits<cr>", { desc = "git commits" })
keymap("n", "han", pick .. "git_hunks<cr>", { desc = "git hunks" })

-- Fugitive
keymap("n", "hg", ":vertical G | vertical resize 60<CR>", { desc = "git status" }) --top overview
keymap("n", "haf", ":G blame -w -s<cr>", { desc = "git blame" }) -- fault
keymap("n", "har", ":Git log<cr>", { desc = "git log" }) -- use this to see commits and rebase
-- don't use Gvdiffsplit! Downloads a :fugitive folder and messes up :Git command

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
keymap("n", "<leader>aw", argon.save_args,        { desc = "Arglist: Write" })
keymap("n", "<leader>aa", argon.add_buffer_to_end,{ desc = "Arglist: Add current" })
keymap("n", "<leader>ai", argon.echo_argslist,    { desc = "Arglist: Show" })
keymap("n", "<leader>ad", ":argdelete %<CR>", { desc = "Arglist: Delete current" })
keymap("n", "<leader>a*", ":argdelete *<CR>", { desc = "Arglist: Clear all" })

--******************************************************************
-- ACTIONS
--*******************************************************************
-- lsp gr series (project changes) | (grr = ref (*), grn = name-change (project-wide), gri = implementation, gd = jump to definition), gra = code actions
  -- code actions aka code suggestions: (import missing modules, typos, remove unused var, etc )

-- GENERAL
keymap({"n", "v"}, "|", H.toggle_fullscreen, opts)
keymap("n", "<leader>en", ":qa!<cr>", opts) -- Exit: no changes
keymap("n", "<leader>ew", ":xa<cr>", opts)  -- Exit: write
keymap("c", "<Down>", "<C-n>", opts)
keymap("c", "<Up>",   "<C-p>", opts)
keymap("n", "<leader>w", ":set wrap!<cr>", { desc = "set wrap" })
keymap("n", "<leader>I", "<cmd>restart<cr>", { desc = "restart file" })
keymap("n", "<leader>i", ":source %<cr>", { desc = "source file" }) -- install

-- CASING (instance)
local function title_case_line()
  cmd("silent! keeppatterns s/^.*$/\\L&/")
  cmd("silent! keeppatterns s/\\<\\w\\+\\>/\\u&/g")
end
keymap({"n", "v"}, "lui", "gUiw", opts)
keymap("n", "lci", "bgUl<right>gue", opts)
keymap({"n", "v"}, "luu", "gUU", opts)
-- Map in Normal mode
keymap("n", "lcc", title_case_line, { desc = "Title-case entire line" })

-- Session (Aka entry, env)
keymap("n", "hie",   ":so Session.vim<cr>", opts)
keymap("n", "<leader>mw", ":mks!<cr>")

-- Spellcheck
keymap('n', "<leader>g", "zg", opts) -- good
keymap('n', "<leader>b", "zw", opts) -- bad
keymap('n', "gn", "]szz" )
keymap('n', "gp", "[szz" )
keymap("n", "ls", function() o.spell = not vim.opt.spell:get() end, { desc = "Toggle spellcheck" })

--DELETE
-- ctrl h is how tmux/shell understands ctrl bspc
keymap({"i", "c"}, "<C-H>", "<C-w>")
keymap({"i", "c"}, "<C-BS>", "<C-w>")
keymap({"i", "c"}, "<S-End>", "<esc>v<end>dO")

-- TAB TO INDENT
-- <Tab> is represented as <C-i> in terminal/tmux. Remap. Use Ctl-m for loc jumping
keymap("n", "<Tab>", ">>", opts)
keymap("v", "<Tab>", ">gv", opts)
keymap("n", "<S-Tab>", "<<", opts)
keymap("v", "<S-Tab>", "<gv", opts)
keymap("i", "<S-Tab>", "<C-d>", opts)


-- CLIPBOARD (3 clipboards: sys(+), yank(0), custom(a))
keymap({ "n", "v" }, "<leader>y", '"ay', { desc = "copy to temp" }) -- temp register
keymap({ "n", "v" }, "<leader>p", '"ap', { desc = "paste from temp" }) -- temp register
keymap({ "n", "v" }, "<C-c>", '"+y')
keymap({ "n", "v" }, "<C-v>", '"+p', opts )
keymap("i", "<C-v>", "<C-r>+") --paste in insert mode

-- SELECTIONS
keymap("n", "<A-a>", "GVgg")
keymap("n", "<S-end>", "V")

-- SEARCH AND REPLACE (EXCHANGE)
------------------------------------------------------------
-- better * (*N) hackish, but works with flickering. This longer command doesn't flicker
keymap({"n", "v"}, "*",
  ":let @/='\\<'.expand('<cword>').'\\>'<CR>:set hlsearch<CR>",
  opts)

-- edit (replace (inner, all), global (delete, yank, fall))
  -- use \v very magic mode for capture groups
keymap( { "n", "v" }, "hei", ":s///g<Left><Left><Left>",      { noremap = true, desc = "replace line/selection" })
keymap( { "n", "v" }, "hea", ":%s///g<Left><Left><Left>",     { noremap = true, desc = "replace in buffer"      })
keymap( { "n", "v" }, "hec", ":s/\\v//g<Left><Left><Left>",   { noremap = true, desc = "replace capture"        })
keymap({ "n", "v" }, "hew", [[:silent! s/^\s\+//<CR><cmd>nohlsearch<CR>]], { desc = "Remove leading whitespace" })

-- linewise alter
keymap( { "n", "v" }, "lay", ":g//y A<Left><Left><Left><Left>", { noremap = true, desc = "global yank" })
keymap( { "n", "v" }, "lad", ":g//d<Left><Left>", { noremap = true, desc = "global delete" })
keymap( { "n", "v" }, "law", ":g/^$/d<cr>", { noremap = true, desc = "clear whitespace lines" })
keymap( { "n", "v" }, "lat", ":g//m0<Left><Left><Left>", { noremap = true, desc = "move to top" })
keymap( { "n", "v" }, "lab", ":g//m$<Left><Left><Left>", { noremap = true, desc = "move to bottom" })

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
keymap("n", "<leader>*", function() H.execute_action("run") end, { desc = "Run current file" })
keymap("n", "<C-*>", function() H.execute_action("test") end, { desc = "Run test-file" })

-- OPEN CLOSE
keymap({ "n", "v" }, "<C-w>", "<cmd>:q!<cr>", { noremap = true, nowait = true }) -- window close (closes panes, tabs(if it's the last pane of tab) and nvim if it's the last pane)
keymap("t", "<Esc>", "<C-\\><C-n>:bd!<CR>", opts) --nnn.nvim opens in a terminal window..allows you to escape with 1 esc
keymap({ "n", "v" }, "<C-g>", ":bd<cr>", { silent = true })

-- PANES/TABS
keymap("n", "<A-n>", ":vsplit<CR>", opts)
keymap("n", "<A-N>", ":split<CR>", opts)
keymap({ "n", "v" }, "<A-h>", ":vsplit<cr>:term<cr>")
keymap("n", "<A-w>", ":tabnew<cr>")
keymap({"n", "v"}, "g'", "gt", opts)
keymap("n", "<A-l>", ":vertical resize +10<CR>", { silent = true, desc = "Resize window right" })
keymap("n", "<A-s>", "<C-w>=<CR>", { silent = true, desc = "Make windows equal size" })

-- TERM NAV
keymap("t", "<A-l>", [[<C-\><C-n>:vertical resize +10<CR>i]], { silent = true, desc = "Resize window right (Terminal)" })
keymap("t", "<A-s>", [[<C-\><C-n><C-w>=i]], { silent = true, desc = "Make windows equal size (Terminal)" })
keymap("t", "<del>", [[<C-\><C-n>zz]], opts)

-- BUFFERS
keymap({ "n", "v" }, "<del>", ":b#<CR>", opts)
keymap({ "n", "v" }, "<C-h>", "<C-w>w", opts)
keymap({"n", "v"}, "<C-BS>", "<C-w>w", opts)
keymap({"n", "v"}, "<C-h>", "<C-w>w", opts)

-- SCROLL AND CENTER
keymap("n", "<C-e>", "5<C-e>")
keymap("n", "<C-y>", "5<C-y>")
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap({"n", "v"}, "<ScrollWheelUp>", "5kzz")
keymap({"n", "v"} , "<ScrollWheelDown>", "5jzz")
keymap("n", "<C-t>", "g;zz") -- time bound
keymap("n", "<C-n>", "g,zz") -- newer change
keymap("n", "<A-right>", "<C-i>")
keymap("n", "<A-left>", "<C-o>zz")
keymap("n", "<A-right>", "<C-i>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "''", "''zz")
keymap("n", "``", "``zz")
keymap({"n", "v"}, "u", "uzz", opts)
keymap({"n", "v"}, "<C-r>", "<C-r>zz", opts)

for i = string.byte('a'), string.byte('z') do
  local letter = string.char(i)
  keymap({"n", "v"}, "'" .. letter, H.centered_act("'", letter))
  keymap({"n", "v"}, "`" .. letter, H.centered_act("`", letter))
end
for i = string.byte('A'), string.byte('Z') do
  local letter = string.char(i)
  keymap({"n", "v"}, "'" .. letter, H.centered_act("'", letter))
  keymap({"n", "v"}, "`" .. letter, H.centered_act("`", letter))
end

-- QUICKFIX LIST (search)
keymap("n", "<leader>l", require("quicker").toggle, { desc = "Toggle quickfix", })
keymap("n", "<leader>so", ":vimgrep  **/*<C-left><left>") -- omni
keymap("n", "<leader>se", ":vimgrep  %<C-left><left>") -- 1 element
keymap("n", "<F2>", ":cp<cr>")
keymap("n", "<F3>", ":cn<cr>")

-- OPEN KEY FILES
-- k (outline, nvim, keyboard, tmux, aliases)
keymap("n", "<leader>r", function()	H.open_root_file("README.md") end, { desc = "README.md" })
keymap("n", "<leader>n", "<cmd>e ~/Doc/notes/tmp/_notes.md<cr>" , { desc = "notes.md" })
keymap("n", "<leader>t", ":e ~/Doc/notes/tmp/_tmp.md<CR>", { desc = "temp.md" })
keymap("n", "<leader>ko", ":e ~/Doc/notes/etc/keys.md<CR>", { desc = "Nvim keymaps" })
keymap("n", "<leader>kn", ":e ~/Dotfiles/nvim/lua/keymaps.lua<CR>", { desc = "Nvim keymaps" })
keymap("n", "<leader>kk", ":e ~/Dotfiles/qmk/keymap.c<CR>", { desc = "Nvim keymaps" })
keymap("n", "<leader>kt", ":e ~/Dotfiles/.tmux.conf<CR>", { desc = "Nvim keymaps" })
keymap("n", "<leader>ka", ":e ~/Dotfiles/.bashrc<CR>", { desc = "Nvim keymaps" })
