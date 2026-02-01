local o = vim.opt
local g = vim.g
-- a lot of settings set by mini.basics

-- COLORS
hl(0, "CursorLineNr", { fg = "#FFFFFF", bg = "#4050C0", bold = true, italic = true })
hl(0, "CursorLine", {bg = "#404040" })
hl(0, "Visual", { bg = "#6040B0", italic = true })
hl(0, "MatchParen", { fg = "#fff44f", bold = true, italic = true })
hl(0, "Search", { bg = "#944475", bold = true, italic = true })
hl(0, "MiniCursorWord", { bg = "NONE", bold = true, italic = true, underline = true })
hl(0, "MiniDiffOverlay", { fg = "#00ff00", bg = "#440000", })
hl(0, "DiffChange", { fg = "white", bg = "#4A3D39"})
hl(0, 'SpellBad', { fg = 'white', bg = '#654055', bold = true })

-- GENERAL
g.mapleader = " "
g.localleader = "l"

g.netrw_list_hide = '^%.$'
g.netrw_liststyle = 3
g.netrw_hide = 1
g.markdown_recommended_style = 0
o.swapfile = false
o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
g.netrw_keepdir = 0 -- alows mini.pick to use arg directory not the cwd when entered

-- VISUAL
o.statusline = "%#TabLineFill# %{v:lua.string.upper(v:lua.vim.fn.mode())} "
  .. "%#PmenuSel#%{v:lua.get_git_branch()}"
  .. "%#TabLineFill# %f "
  .. "%#PreInsert#%{v:lua.get_active_treesitter()}"
  .. "%#Function#%{v:lua.get_clean_lsp()}"
  .. "%#ModeMsg# %l/%L | %p%% "
  .. "%#DiagnosticInfo# %m"
o.signcolumn = "yes"
o.colorcolumn = "80"
o.cursorlineopt = "both"
o.relativenumber = true
o.termguicolors = true
o.foldcolumn = "1"
o.background = "dark"
o.guicursor = "n-v-c-sm:block,i-ci-ve:ver25"
vim.diagnostic.config({ virtual_text = false })

-- TABS, INDENTATION, WRAPPING
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.breakindent = true
o.wrap = true
o.linebreak = true

-- *****************************************************
-- FUNCTIONS
-- *****************************************************
_G.get_git_branch = function()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
  if branch == "" or branch:find("fatal") then return "" end
  return "  " .. branch .. " "
end

_G.get_clean_lsp = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return "󰊠" end
  return " 󱐋:" .. clients[1].name .. " "
end

_G.get_active_treesitter = function()
  local buf = vim.api.nvim_get_current_buf()
  local active = vim.treesitter.highlighter.active[buf]
  if not active then return "󰊠 " end
  return "  "
end

