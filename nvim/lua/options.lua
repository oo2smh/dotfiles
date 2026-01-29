local o = vim.opt
local g = vim.g
local formatoptions = o.formatoptions
-- a lot of settings set by mini.basics

-- *****************************************************
-- OPTIONS
-- *****************************************************
-- COLORS
hl(0, "CursorLineNr", { fg = "#FFFFFF", bg = "#4050C0", bold = true, italic = true })
hl(0, "CursorLine", {bg = "#454545"})
hl(0, "Visual", { bg = "#6040B0", italic = true })
hl(0, "MatchParen", { fg = "#fff44f", bold = true, italic = true, underline = true })
hl(0, "Search", { bg = "#944475", bold = true, italic = true })
hl(0, "MiniCursorWord", { bg = "NONE", bold = true, italic = true, underline = true })
hl(0, "MiniDiffOverlay", { fg = "#00ff00", bg = "#440000", })

-- GENERAL
g.mapleader = " "
g.netrw_list_hide = '^%.$'
g.netrw_liststyle = 3
g.netrw_hide = 1

g.netrw_keepdir = 0 -- allows mini.pick to use arg directory not the cwd when entered
o.virtualedit = "block" -- visual block allowed to go past to nonvisual char
o.relativenumber = true
o.signcolumn = "yes"
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

-- WRAPPING
o.breakindent = true
o.colorcolumn = "80"
o.linebreak = true
o.wrap = true

-- COLOR
o.termguicolors = true
o.background = "dark"
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

-- AUTO-ENTER INSERT MODE WHEN ENTERING TERMINAL
autocmd({ "TermOpen", "BufEnter" }, {
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
        end
    end,
})

autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    local ok, render_md = pcall(require, "render-markdown")
    if not ok then return end

    -- Plugin setup
    render_md.setup({
      render_modes = { "n", "c", "t", "i" },
      heading = { render_modes = true, sign = false },
      code = { render_modes = true, sign = false },
      quote = { render_modes = true },
      bullet = { render_modes = true },
      link = { render_modes = true },
    })

    -- Highlights
    hl(0, "RenderMarkdownH1Bg", { fg = "#444444", bg = "#DCD7A0", bold = true })
    hl(0, "RenderMarkdownH2Bg", { fg = "#FFA500", bold = true })
    hl(0, "RenderMarkdownH3Bg", { fg = "#FF6347", bold = true })
    hl(0, "RenderMarkdownH4Bg", { fg = "#9370DB", bold = true })
    hl(0, "RenderMarkdownH5Bg", { fg = "#1E90FF", bold = true })
    hl(0, "RenderMarkdownH6Bg", { fg = "#00CED1", bold = true })
  end,
})
