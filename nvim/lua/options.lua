local opt = vim.opt
local g = vim.g

-- NETRWC
g.netrw_banner = 0
g.netrw_list_hide = "^[.]"
g.netrw_keepdir = 0
g.netrw_winsize = 20

-- SESSIONS
opt.sessionoptions = {
	"buffers",
	"curdir",
	"tabpages",
	"winsize",
	"globals",
	"folds",
}

-- GENERAL
opt.relativenumber = true
opt.number = true
opt.cursorline = true
opt.hlsearch = false
opt.cursorlineopt = "number"
opt.swapfile = false
opt.undodir = os.getenv("HOME") .. "/.local/share/undodir"
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
opt.breakindent = true
opt.colorcolumn = "80"
opt.wrap = true
opt.linebreak = true

-- COLOR
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25"

-- INLINE ERRORS (for lsp disabled)
vim.diagnostic.config({ virtual_text = false })
