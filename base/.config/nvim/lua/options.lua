local g = vim.g

--************************************
-- OPTIONS
--************************************
-- lot of settings are set by mini.basics
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.hl.priorities.semantic_tokens = 95
vim.opt.viewoptions = "folds"
vim.opt.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize"
-- o.clipboard = "unnamedplus"
o.fdm = "manual"
o.spellcapcheck = "" -- disable first line letter cap to false
g.mapleader = " "
g.localleader = "l"
g.netrw_list_hide = '^%.$'
g.netrw_liststyle = 3
g.netrw_hide = 1
g.markdown_recommended_style = 0
o.swapfile = false
o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
g.netrw_keepdir = 0 -- allows mini.pick to use arg directory not the cwd when entered

-- VISUAL
o.statusline = "%#TabLineFill# %{v:lua.string.upper(v:lua.vim.fn.mode())} "
    .. "%#Search#%{v:lua.get_git_branch()}"
    .. "%* %f "
    .. "%#WarningMsg#%p%%"
    .. "%#DiagnosticOk# %m%<%="
    .. "%#Statement#%{%v:lua.count_searches()%} "
    .. "%#DiagnosticOk#%{v:lua.get_active_treesitter()}"
    .. "%#Directory#%{v:lua.get_clean_lsp()}"
o.laststatus = 2
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
-- HELPER FUNCTIONS
-- *****************************************************
_G.get_git_branch = function()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null"):gsub("\n", "")
  if branch == "" or branch:find("fatal") then return "" end
  return "  " .. branch .. " "
end

_G.get_clean_lsp = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients == 0 then return " 󰊠 " end

  local names = {}
  for _, client in ipairs(clients) do
    if client.name ~= "mini.snippets" then
      table.insert(names, client.name)
    end
  end

  if #names == 0 then
    return " 󰊠 "
  end

  return " 󱐋:" .. table.concat(names, "|") .. " "
end

_G.get_active_treesitter = function()
  local buf = vim.api.nvim_get_current_buf()
  local active = vim.treesitter.highlighter.active[buf]
  if not active then return " 󰊠 " end
  return "  "
end

_G.count_searches = function()
  local p = vim.fn.getreg("/")
  local sc = vim.fn.searchcount({ recompute = 1, maxcount = 9999 })
  if p == "" or sc.total == 0 then return "" end

  -- Clean up Vim regex noise
  p = p:gsub([[\<]], ""):gsub([[\>]], ""):gsub([[\V]], ""):gsub([[\c]], ""):gsub("%%", "%%%%")

  -- Truncate to 5 characters
  if #p > 15 then p = p:sub(1, 15) .. "…" end

  return string.format("%d/%d %s", sc.current, sc.total, p)
end
