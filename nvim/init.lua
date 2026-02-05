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

packadd({ -- (25 plugins)
  -- languages
  gh .. "nvim-treesitter/nvim-treesitter",
  gh .. "neovim/nvim-lspconfig",
  gh .. "williamboman/mason.nvim",
  gh .. "williamboman/mason-lspconfig.nvim",
  gh .. "nvim-treesitter/nvim-treesitter-textobjects", -- used in mini.ai for treesitter

  gh .. "nvim-mini/mini.nvim",
  gh .. "luukvbaal/nnn.nvim",
  gh .. "tpope/vim-fugitive",
  gh .. "MeanderingProgrammer/render-markdown.nvim",
  -- gh .. "stevearc/quicker.nvim", -- downloaded and move to core/start
})

-- *****************************************************
-- ZONE: SIMPLE CONFIGS
-- *****************************************************
cmd("colorscheme age")
require("nnn").setup({ cd = true, quitcd = "lcd", auto_close = true, set_hidden = false, session = "shared" })
require("mini.basics").setup()
require("mini.pairs").setup()
require("mini.surround").setup()

require("mini.completion").setup()
require("mini.icons").setup()
require("mini.extra").setup()
require("mini.diff").setup({ update_delay = 50, view = { style = "number" }})
require("mini.pick").setup({ window = { config = { anchor = "NW", row = 20, width = 100, height = 30 }} })
require("mini.align").setup()
-- keymaps.lua (MINI: splitjoin, operators, ai)

-- *****************************************************
-- ZONE: LSP & TREESITTER
-- *****************************************************
-- LSP 🗣️
require("mason").setup()
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
        group = "MiniHipatternsTodo",
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

require('render-markdown').setup({
  render_modes = { "n", "c", "t", "i" },
  heading = { render_modes = true, signs = false, icons = {"","","","","",""}},
  code = { render_modes = true, sign = false },
  quote = { render_modes = true },
  bullet = { render_modes = true, icons = {"•", "‣", "▪", "✧"} },
  link = { render_modes = true },
  pipe_table = { render_modes = true },
  inline_highlight = { render_modes = true },
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
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),
    gen_loader.from_lang(),
  },
  mappings = { expand = '<C-t>', jump_next = '<Tab>', jump_prev = '<S-Tab>', stop = '<C-t>' },
  expand   = { match = match_strict },
})
require('mini.snippets').start_lsp_server()

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
