local o = vim.opt
local g = vim.g
-- a lot of settings set by mini.basics

-- GENERAL
g.netrw_keepdir = 0 -- allows mini.pick to use arg directory not the cwd when entered
o.virtualedit = "block" -- visual block allowed to go past to nonvisual char
o.foldmethod = "manual"
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
o.colorcolumn = "75"
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
local autocmd = vim.api.nvim_create_autocmd
local formatoptions = o.formatoptions

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
