local plenary = { "nvim-lua/plenary.nvim", lazy = true }
local marks = { "chentoast/marks.nvim", event = "VeryLazy", config = true }
local nnn = {
	"luukvbaal/nnn.nvim",
	keys = { { "<leader>n", ":NnnPicker %:p:h<CR>", desc = "Open Nnn" } },
	opts = {
		-- quitcd = "cd",
		set_hidden = true,
		session = "shared",
		auto_close = true,
	},
}

--h: MINI BASE
local m_basics = { "echasnovski/mini.basics", config = true }
local m_pairs = { "echasnovski/mini.pairs", config = true }
local m_statusline = { "echasnovski/mini.statusline", config = true }
local m_tabline = { "echasnovski/mini.tabline", config = true }
local m_sessions = { "echasnovski/mini.sessions", opts = { autoread = false, autowrite = true } }

-- the prebuilt options are [FIX, HACK, TODO, WARN, NOTE, TEST, PERF]
-- h: FOLKE HIGHLIGHTS
local highlights = {
	"folke/todo-comments.nvim",
	opts = {
		keywords = {
			h = { color = "orange", alt = { "H", "heading", "header" } },
			doc = { color = "blue", alt = { "ref" } },
			key = { color = "info", alt = { "keys" } },
		},
		colors = {
			orange = { "#FFC067" },
			blue = { "#90D5FF" },
		},
	},
	config = true,
}
-- h: COLOR SCHEME
local colorscheme = {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,

	config = function()
		require("tokyonight").setup({
			on_colors = function(colors)
				colors.bg = "#000000"
			end,
		})
		vim.cmd([[colorscheme tokyonight]])
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#FFFF00", bg = "#000000", bold = true })
	end,
}

return { plenary, marks, nnn, m_basics, m_pairs, m_statusline, m_tabline, m_sessions, highlights, colorscheme }
