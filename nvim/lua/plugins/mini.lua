local m_basics      = { "echasnovski/mini.basics", config = true }
local m_statusline  = { "echasnovski/mini.statusline", config = true }
local m_tabline     = { "echasnovski/mini.tabline", config = true }
local m_indentscope = { "echasnovski/mini.indentscope", config = true }
local m_pairs       = { "echasnovski/mini.pairs", config = true }
local m_surround    = { "echasnovski/mini.surround", config = true }
local m_align       = { "echasnovski/mini.align", config = true }
local m_splitjoin   = { "echasnovski/mini.splitjoin", config = true }

local m_pick        = {
  "echasnovski/mini.pick",
  version = false,
  dependencies = { { "echasnovski/mini.extra", "echasnovski/mini.icons" } },
  config = function()
    require("mini.pick").setup()
    require("mini.extra").setup()
  end,
  keys = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra").pickers

    return {
      { "h",          pick.builtin.files },
      { "<leader>h",  function() extra.oldfiles() end },
      { "<C-h>",      function() extra.git_files() end },
      { "<leader>s",  pick.builtin.grep_live },
      { "<leader>q",  pick.builtin.help },
      { "<leader>gc", function() extra.git_commits() end },
      { "<leader>gb", function() extra.git_branches() end },
      { "<leader>da", function() extra.diagnostic() end },
      { "<leader>dl", function() extra.diagnostic({ scope = 'current' }) end },
      { "<leader>m",  function() extra.marks({ scope = 'buf' }) end },
      { "<leader>u",  function() extra.list({ scope = 'change' }) end },
      { "<leader>c",  function() extra.registers() end },
    }
  end,
}

local m_operators   = {
  "echasnovski/mini.operators",
  config = true,
  opts = { exchange = { prefix = "go" } },
}

local m_diff        = {
  "echasnovski/mini.diff",
  version = false, -- always use the latest
  config = function()
    local diff = require("mini.diff")
    diff.setup({
      view = { style = "sign" },

    })
    vim.keymap.set('n', '<leader>k', function()
      diff.toggle_overlay(0)
    end, { desc = 'MiniDiff: Toggle overlay' })
  end,
}

return {
  -- FUNCTIONALITY
  m_surround,  -- select visual selection first (sa, sd, sr)
  m_pairs,     -- autopairs for enclosers (){}[]``''""
  m_pick,      -- viewer
  m_operators, -- go(rient), gs(ort), gr(eplace with register), gm(ultiply)

  -- READABILITY -- optional formatting enhancements
  m_splitjoin, -- toggle folding for args gS within encloser
  m_align,     -- 1. select 2. ga(lign) 3. symbol (comments, =, md tables)

  -- VISUAL
  m_basics,      -- highlight on yank
  m_statusline,  -- visual
  m_tabline,     -- visual
  m_diff,        -- show differences in diff in sign column
  m_indentscope, -- visual scope cues
}
