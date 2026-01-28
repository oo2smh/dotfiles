local m_basics      = { "nvim-mini/mini.basics",      config = true }
local m_statusline  = { "nvim-mini/mini.statusline",  config = true }
local m_tabline     = { "nvim-mini/mini.tabline",     config = true }
local m_indentscope = { "nvim-mini/mini.indentscope", config = true }
local m_pairs       = { "nvim-mini/mini.pairs",       config = true }
local m_surround    = { "nvim-mini/mini.surround",    config = true }
local m_splitjoin   = { "nvim-mini/mini.splitjoin",   opts   = { mappings = { toggle = "mo"}}}
local m_cursorword  = { "nvim-mini/mini.cursorword",  config = true }
local m_notify      = { "nvim-mini/mini.notify",      config = true }
local m_align       = { "nvim-mini/mini.align",       config = true }

local m_completion  = { "nvim-mini/mini.completion",
  dependencies = {{"nvim-mini/mini.icons"}},
  config = function()
    require("mini.completion").setup()
    require("mini.icons").setup()
  end,
}

local m_pick = {
  "nvim-mini/mini.pick",
  version = false,
  dependencies = { { "nvim-mini/mini.extra", "nvim-mini/mini.icons" } },
  opts = {
    window = {
      config = {
        anchor = 'NW',
        row = 20,
        width = 100, height = 30,
      },
    },
    -- for the sake of convienience, I can't type these in picker float
    mappings = {
      toggle_preview = '1',
      scroll_down = '2',
      scroll_up = '3',
    },
  },

  keys = function()
    require("mini.icons").setup()
    local pick = require("mini.pick")
    local extra = require("mini.extra").pickers

		return {
			-- git
			{"hab", function() extra.git_branches() end, { desc = "git branches" }},
			{"han", function() extra.git_hunks() end, { desc = "git hunks" }},
			{"hai", function() extra.git_commits() end, { desc = "git commits" }},
			-- other
			{"ht", pick.builtin.files, { desc = "files" } },
			{"ho", pick.builtin.buffers, { desc = "open buffers" } }, --existing
			{"hp", function() extra.diagnostic() end, { desc = "project diagnostic" }},
			{"hd", function() extra.diagnostic({ scope = "current" }) end, { desc = "file diagnostic" }},
			{"hs", pick.builtin.grep_live, { desc = "string search" }},
			{"hr", function() extra.registers() end, { desc = "registers"}},
			{"hz", function() extra.hipatterns({ scope = "current", highlighters = {"zone"}}) end, { desc = "highlights"}},
			{"hf", function() extra.hipatterns({highlighters = {"fix"}}) end, { desc = "highlights"}},
			{"hm", function() extra.marks({ scope = "buf" }) end, { desc = "marks" }},
			{"hM", function() extra.marks({ scope = "global" }) end, { desc = "marks" }},
			{"hh", pick.builtin.help, { desc = "help manuals" } },
      {"hk", function() extra.keymaps() end, { desc = "keymaps"}},
    }
  end,
}

local m_operators = {
	"nvim-mini/mini.operators",
	config = true,
	opts = { exchange = { prefix = "go" }},
}

local m_diff = {
	"nvim-mini/mini.diff",
	version = false, -- always use the latest
	options = {update_delay = 50,},
	config = function()
		local diff = require("mini.diff")
		vim.api.nvim_set_hl(0, "MiniDiffOverlay", { fg = "#00ff00", bg = "#440000" })

		diff.setup({view = { style = "number" }})
		vim.keymap.set("n", "hu", function()
			diff.toggle_overlay(0)
		end, { desc = "MiniDiff: toggle diff overlay" })
	end,
}

local m_hipatterns = {
	"nvim-mini/mini.hipatterns",
	config = function()
		require("mini.hipatterns").setup({
			highlighters = {
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote"  },
				zone = { pattern = "%f[%w]()ZONE()%f[%W]", group = "RenderMarkdownH1"    },
        fix  = { pattern = "%f[%w]()FIX()%f[%W]",  group = "MiniHipatternsFixme" },
				hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
			},
		})
	end,
}

return {
	-- FUNCTIONALITY (7)
	m_basics,      -- highlight on yank, g/ search within selection, jk, options setting
	m_pick,        -- viewer
	m_operators,   -- go(rient+switch), gs(ort), gr(eplace with register), gm(ultiply)
	m_pairs,       -- autopairs for enclosers (){}[]``''""
	m_surround,    -- sa, sd, sr
	m_diff,        -- select (gh): to add hunk, select (gH): reset, hu (see diff)
	m_completion,  -- autocomplete better

  -- READABILITY: formatting enhancements
	m_splitjoin,   -- toggle folding for args (mo)
	m_align,       -- ga(symbol)

  -- VISUAL UX (6)
	m_statusline,  -- visual
	m_tabline,     -- visual
	m_indentscope, -- visual scope cues
	m_hipatterns,  -- pattern matching highlights. Used for hex highlighting
	m_cursorword,  -- highlights word under cursor
	m_notify,      -- lsp progress notification
}


