-- Disable the crashing function entirely
vim.lsp.handlers["textDocument/documentColor"] = function() end

-- Force-dummy the contrast calculation that is failing
-- This prevents the "Invalid color format" error from ever being thrown
local lsp_color = _G.vim.lsp.document_color
if lsp_color then
  lsp_color.get_contrast_color = function() return "#000000" end
end
-- *****************************************************
-- ZONE: GLOBAL VARIABLES
-- *****************************************************
vim           = vim
keymap        = vim.keymap.set
cmd           = vim.cmd
autocmd       = vim.api.nvim_create_autocmd
api           = vim.api
hl            = vim.api.nvim_set_hl
o             = vim.opt

-- *****************************************************
-- ZONE: PLUGINS
-- *****************************************************
local packadd = vim.pack.add
local gh      = "https://github.com/"

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
  gh .. "supermaven-inc/supermaven-nvim",
  gh .. "stevearc/conform.nvim",
  gh .. "windwp/nvim-ts-autotag",
  -- gh .. "stevearc/quicker.nvim", -- downloaded and move to core/start
})

-- *****************************************************
-- ZONE: SIMPLE CONFIGS
-- *****************************************************
cmd("colorscheme age")

require("supermaven-nvim").setup({ keymaps = { accept_suggestion = "<C-S>" } })
require("nnn").setup({ cd = true, quitcd = "lcd", auto_close = true, set_hidden = false, session = "shared" })
require("quicker").setup()
require("mini.basics").setup()
require("mini.pairs").setup()
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.extra").setup()
require("mini.diff").setup({ update_delay = 50, view = { style = "number" } })
require("mini.pick").setup({ window = { config = { width = 90, height = 35 } } })
require("mini.align").setup()
-- keymaps.lua (MINI: splitjoin, operators, ai)
require("mini.surround").setup()
require('mini.indentscope').setup({ symbol = '│', })

-- *****************************************************
-- ZONE: LSP & TREESITTER
-- *****************************************************
-- LSP 🗣️
local lsp = vim.lsp.config
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "vimls", "html" },
  automatic_installation = true,
})

lsp('pyright', {
  autostart = true,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        extraPaths = { ".", "./src" },
      },
    },
  },
})

require("conform").setup({
  formatters_by_ft = {
    html = { "prettier" },
    css = { "prettier", "collapse_css" },
    json = { "prettier" },
  },
  formatters = {
    prettier = {
      prepend_args = { "--print-width", "10000" },
    },
    collapse_css = {
      command = "perl",
      args = {
        "-0777",
        "-pe",
        's/\\{\\s*\\n\\s*((?!--)[^{};]+;)\\s*\\n\\s*\\}/{ $1 }/g'
      },
      stdin = true,
    },

  },
  format_on_save = {
    timeout_ms = 1000, -- Bumped to 1s to ensure both finish
    lsp_fallback = true,
  },
})

-- TREESITTER 🌲
require("nvim-treesitter").setup({
  ensure_installed = { "markdown", "python", "lua", "yaml", "html", "javascript", "tsx", "c", "toml", "css" },
  highlight = { enable = true, additional_vim_regex_highlighting = { 'markdown' } },
  auto_install = true,
})

require('nvim-ts-autotag').setup({
  opts = {
    -- default options
    enable_close = true,          -- Auto close tags
    enable_rename = true,         -- Auto rename tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
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
  heading = { render_modes = true, signs = false, icons = { "", "", "", "", "", "" } },
  code = { render_modes = true, sign = false },
  quote = { render_modes = true },
  bullet = { render_modes = true, icons = { "•", "‣", "▪", "✧" } },
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
  mappings = { expand = '<C-t>', jump_next = '<Tab>', jump_prev = '<S-Tab>', stop = '<Esc>' },
  expand   = { match = match_strict },
})
require('mini.snippets').start_lsp_server()

-- tab to expand
local expand_or_jump = function()
  local can_expand = #mini_snippets.expand({ insert = false }) > 0
  if can_expand then
    vim.schedule(mini_snippets.expand); return ''
  end
  local is_active = mini_snippets.session.get() ~= nil
  if is_active then
    mini_snippets.session.jump('next'); return ''
  end
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


-- silence css oklch errors
local function silence_oklch_errors()
  local original_err = vim.api.nvim_err_writeln
  vim.api.nvim_err_writeln = function(msg)
    -- This catches the specific Nightly runtime crash
    if msg:find("document_color.lua") or msg:find("Invalid color format") then
      return
    end
    original_err(msg)
  end
end

silence_oklch_errors()

-- *****************************************************
-- MODULES
-- *****************************************************
require("options")
require("keymaps")
require("argslist")
require("autocmds")
