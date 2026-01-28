-- *****************************************************
-- VARIABLES
-- *****************************************************
-- GLOBAL VARS
keymap  = vim.keymap.set
cmd     = vim.cmd
autocmd = vim.api.nvim_create_autocmd
api     = vim.api

-- LOCAL VARS
local o = vim.opt
local g = vim.g
local formatoptions = o.formatoptions

-- *****************************************************
-- OPTIONS
-- *****************************************************
-- a lot of settings set by mini.basics

-- GENERAL
g.mapleader = " "
g.netrw_banner = 0
g.netrw_list_hide = '^%.$'
g.netrw_liststyle = 3
g.netrw_hide = 1

g.netrw_keepdir = 0 -- allows mini.pick to use arg directory not the cwd when entered
o.virtualedit = "block" -- visual block allowed to go past to nonvisual char
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "both"
o.swapfile = false
o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
o.undofile = true

-- TABS & INDENTATION
g.markdown_recommended_style = 0
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.showmatch = true

-- WRAPPING
o.breakindent = true
o.colorcolumn = "80"
o.wrap = true
o.linebreak = true

-- COLOR
o.termguicolors = true
o.background = "dark"
o.signcolumn = "yes"
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25"

-- INLINE ERRORS (for lsp disabled)
vim.diagnostic.config({ virtual_text = false })

-- *****************************************************
-- AUTOCMDS
-- *****************************************************
--PREVENT AUTO COMMENTING NEXT LINES
autocmd("FileType", {
	pattern = "*",
	callback = function()
		formatoptions:remove({ "r", "o" })
	end,
})

autocmd("FileType", {
	pattern = "-",
	callback = function()
		formatoptions:remove({ "r", "o" })
	end,
})

-- REMOVE TRAILING WHITESPACE
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

-- Auto-enter insert mode when entering terminal
autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
        end
    end,
})

-- *****************************************************
-- MODULES LOADING
-- *****************************************************
require("lazy_init")
require("keymaps")
require("argslist")
