local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- NETRWC
g["netrw_banner"] = 0
g["netrw_list_hide"] = "^[.]"
g["netrw_keepdir"] = 0
g["netrw_winsize"] = 20

-- GENERAL
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
opt.undofile = true

-- TABS & INDENTATION
g.markdown_recommended_style = 0
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.showmatch = true

-- WRAPPING
opt.textwidth = 80
opt.breakindent = true
opt.colorcolumn = "80"
opt.wrap = false
opt.linebreak = true

-- COLOR
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
