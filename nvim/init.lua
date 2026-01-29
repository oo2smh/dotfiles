-- *****************************************************
-- GLOBAL VARIABLES
-- *****************************************************
vim     = vim
keymap  = vim.keymap.set
cmd     = vim.cmd
autocmd = vim.api.nvim_create_autocmd
api     = vim.api
hl      = vim.api.nvim_set_hl

-- *****************************************************
-- PLUGINS
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
  {src = gh .. "szymonwilczek/vim-be-better"},

  -- mini
  {src = mini .. "extra"},
  {src = mini .. "pick"},
  {src = mini .. "icons"},
  {src = mini .. "basics"},
  {src = mini .. "statusline"},
  {src = mini .. "tabline"},
  {src = mini .. "cursorword"},
  {src = mini .. "indentscope"},
  {src = mini .. "notify"},
  {src = mini .. "pairs"},
  {src = mini .. "surround"},
  {src = mini .. "align"},
  {src = mini .. "completion"},
  {src = mini .. "splitjoin"},
  {src = mini .. "hipatterns"},
  {src = mini .. "operators"},
  {src = mini .. "diff"},
})

cmd("colorscheme nightfox")
require("mason").setup()

require("mini.basics").setup()
require("mini.statusline").setup()
require("mini.tabline").setup()
require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.surround").setup()
require("mini.align").setup()
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.extra").setup()

-- *****************************************************
-- CONFIG PACKAGES
-- *****************************************************
require("nnn").setup({ quitcd = "tcd", auto_close = true, set_hidden = true, session = "shared" })
require("mini.splitjoin").setup({mappings = {toggle = "mo"}})
require("mini.operators").setup({exchange = {prefix = "go"}})
require("mini.diff").setup({ update_delay = 50, view = { style = "number", }})
require("mini.pick").setup({
  window = { config = { anchor = "NW", row = 20, width = 100, height = 30 }},
  mappings = { toggle_preview = "1", scroll_down = "2", scroll_up = "3" },
})

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
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
})

-- LSP 🗣️
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "vimls" },
    automatic_installation = true,
    indent = true,
})

-- TREESITTER 🌲
require("nvim-treesitter").setup({
    ensure_installed = { "markdown", "python", "lua", "vim", "vimdoc", "yaml", "javascript", "c" },
    highlight = { enable = true },
})

-- Auto-start treesitter for certain filetypes
local languages = { "markdown", "python", "lua", "vim", "vimdoc", "yaml", "javascript", "c" }
for _, lang in ipairs(languages) do
    autocmd("FileType", {
        pattern = lang,
        callback = function()
            vim.treesitter.start()
        end,
    })
end

-- *****************************************************
-- MODULES
-- *****************************************************
require("options")
require("keymaps")
require("argslist")
