local m_basics      = { "echasnovski/mini.basics", config = true }
local m_statusline  = { "echasnovski/mini.statusline", config = true }
local m_tabline     = { "echasnovski/mini.tabline", config = true }
local m_indentscope = { "echasnovski/mini.indentscope", config = true }
local m_pairs       = { "echasnovski/mini.pairs", config = true }
local m_surround    = { "echasnovski/mini.surround", config = true }
local m_align       = { "echasnovski/mini.align", config = true }
local m_splitjoin   = { "echasnovski/mini.splitjoin", config = true }

local m_sessions    = {
  "echasnovski/mini.sessions",
  keys = function()
    local ms = require('mini.sessions')
    local function save_session()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      local session_name = vim.fn.input("Session name: ", dir_name, "file")

      -- Check if the user pressed <Esc> or entered an empty name
      if session_name == nil or session_name:match('^%s*$') then
        vim.notify("Session save cancelled.", vim.log.levels.INFO)
        return
      end

      ms.write(session_name)
      vim.notify("Attempting to save session as: '" .. session_name .. "'", vim.log.levels.INFO)
    end

    return {
      { "hi",         function() ms.select("read") end },
      { "<leader>ms", save_session },
      { "<leader>md", function() ms.select("delete", { force = true, verbose = true }) end },
    }
  end,
}

local m_pick        = {
  "echasnovski/mini.pick",
  version = false,
  dependencies = { { "echasnovski/mini.extra", "echasnovski/mini.icons" } },
  keys = function()
    local pick = require("mini.pick")
    local extra = require("mini.extra").pickers

    return {
      { "h",          pick.builtin.files },
      { "<leader>ht", function() extra.oldfiles() end },
      { "<leader>hn", function() extra.git_hunks() end },
      { "<leader>hp", function() extra.diagnostic() end },                      -- project diagostic
      { "<leader>hd", function() extra.diagnostic({ scope = 'current' }) end }, --diagnostic file
      { "<leader>hs", pick.builtin.grep_live },
      { "<leader>gc", function() extra.git_commits() end },
      { "<leader>gb", function() extra.git_branches() end },
      { "<leader>q",  pick.builtin.help },
      { "<leader>m",  function() extra.marks({ scope = 'buf' }) end },
      { "<leader>u",  function() extra.list({ scope = 'change' }) end },
      { "<leader>c",  function() extra.registers() end },
      { "<leader>ld", function() extra.lsp({ scope = 'definition' }) end },
      { "<leader>lo", function() extra.lsp({ scope = 'document_symbol' }) end },
      { "<leader>lr", function() extra.lsp({ scope = 'references' }) end },
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
      view = { style = "number" },
    })
    vim.keymap.set('n', '<leader>k', function()
      diff.toggle_overlay(0)
    end, { desc = 'MiniDiff: Toggle overlay' })
  end,
}


return {
  -- FUNCTIONALITY
  m_surround,  -- select visual selection first (sa, sd, sr)
  m_pick,      -- viewer
  m_operators, -- go(rient), gs(ort), gr(eplace with register), gm(ultiply)
  m_pairs,     -- autopairs for enclosers (){}[]``''""

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
