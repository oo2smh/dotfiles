-- *****************************************************
-- ZONE: GLOBAL VARIABLES
-- *****************************************************
vim     = vim
keymap  = vim.keymap.set
cmd     = vim.cmd
autocmd = vim.api.nvim_create_autocmd
api     = vim.api
hl      = vim.api.nvim_set_hl
o       = vim.opt

-- *****************************************************
-- ZONE: PLUGINS
-- *****************************************************
local packadd = vim.pack.add
local gh = "https://github.com/"
local mini = gh .. "nvim-mini/mini."

packadd({
  -- languages
  {src = gh .. "neovim/nvim-lspconfig"},
  {src = gh .. "williamboman/mason.nvim"},
  {src = gh .. "williamboman/mason-lspconfig.nvim"},
  {src = gh .. "windwp/nvim-ts-autotag"},
  {src = gh .. "nvim-treesitter/nvim-treesitter"},

  -- base
  {src = gh .. "EdenEast/nightfox.nvim"},
  {src = gh .. "luukvbaal/nnn.nvim"},
  {src = gh .. "tpope/vim-fugitive"},
  {src = gh .. "azabiong/vim-highlighter"},
  {src = gh .. "MeanderingProgrammer/render-markdown.nvim"},
  -- {src = gh .. "stevearc/quicker.nvim"}, -- download and move to core/start

  -- mini
  {src = mini .. "snippets"},
  {src = mini .. "extra"},
  {src = mini .. "pick"},
  {src = mini .. "icons"},
  {src = mini .. "basics"},
  {src = mini .. "tabline"},
  {src = mini .. "cursorword"},
  {src = mini .. "indentscope"},
  {src = mini .. "pairs"},
  {src = mini .. "surround"},
  {src = mini .. "align"},
  {src = mini .. "completion"},
  {src = mini .. "splitjoin"},
  {src = mini .. "hipatterns"},
  {src = mini .. "operators"},
  {src = mini .. "diff"},
})

-- *****************************************************
-- ZONE: SIMPLE CONFIGS
-- *****************************************************
cmd("colorscheme nightfox")
require("mason").setup()
require("mini.basics").setup()
require("mini.tabline").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.extra").setup()
require("nnn").setup({ quitcd = "tcd", auto_close = true, set_hidden = true, session = "shared" })
require("mini.diff").setup({ update_delay = 50, view = { style = "number" }})
require("mini.pick").setup({ window = { config = { anchor = "NW", row = 20, width = 100, height = 30 }} })

-- *****************************************************
-- ZONE: LSP & TREESITTER
-- *****************************************************
-- LSP 🗣️
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "vimls" },
    automatic_installation = true,
    indent = true,
})

-- TREESITTER 🌲
require("nvim-treesitter").setup({
    ensure_installed = { "markdown", "python", "lua", "yaml", "javascript", "c", "toml"},
    highlight = { enable = true, additional_vim_regex_highlighting = {'markdown'}},
    auto_install = true,
})

-------------------------------------------------------
-- ZONE: MINI.HIGHLIGHTS
-------------------------------------------------------
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
    highlighters = {
      note = {
        pattern = "%f[%w]()NOTE()%f[%W]",
        group = "MiniHipatternsNote",
      },
      fix = {
        pattern = "%f[%w]()FIX()%f[%W]",
        group = "MiniHipatternsFixme",
      },
      zone = {
        pattern = "%f[%w]()ZONE()%f[%W]",
        group = "MiniHipatternsHack",
      },

      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

-------------------------------------------------------
-- ZONE: MINI.SNIPPETS
-------------------------------------------------------
local mini_snippets = require('mini.snippets')
local gen_loader = require('mini.snippets').gen_loader
local match_strict = function(snips)
  return mini_snippets.default_match(snips, { pattern_fuzzy = '%S+' })
end

require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    gen_loader.from_lang(),
  },
  mappings = { expand = '<C-t>', jump_next = '<Tab>', jump_prev = '<S-Tab>', stop = '<C-t>' },
  expand   = { match = match_strict },
})

-- tab to expand
local expand_or_jump = function()
  local can_expand = #mini_snippets.expand({ insert = false }) > 0
  if can_expand then vim.schedule(mini_snippets.expand); return '' end
  local is_active = mini_snippets.session.get() ~= nil
  if is_active then mini_snippets.session.jump('next'); return '' end
  return '\t'
end
local jump_prev = function() mini_snippets.session.jump('prev') end

keymap('i', '<Tab>', expand_or_jump, { expr = true })
keymap('i', '<S-Tab>', jump_prev)

-- exit snippet on mode change
local make_stop = function()
  local au_opts = { pattern = '*:n', once = true }
  au_opts.callback = function()
    while mini_snippets.session.get() do
      mini_snippets.session.stop()
    end
  end
  autocmd('ModeChanged', au_opts)
end
local opts = { pattern = 'MiniSnippetsSessionStart', callback = make_stop }
autocmd('User', opts)

-- *****************************************************
-- MODULES
-- *****************************************************
require("options")
require("keymaps")
require("argslist")
require("autocmds")

