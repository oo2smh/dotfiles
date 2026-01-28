local hl = vim.api.nvim_set_hl

local colorscheme = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		cmd("colorscheme duskfox")
		hl(0, "CursorLineNr", { fg = "#FFFFFF", bg = "#4050C0", bold = true, italic = true })
		hl(0, "CursorLine", {bg = "#454545"})
		hl(0, "Visual", { bg = "#6040B0", italic = true })
      hl(0, "MatchParen", { fg = "#fff44f", bold = true, italic = true, underline = true })
		hl(0, "Search", { bg = "#944475", bold = true, italic = true })
		hl(0, "MiniCursorWord", { bg = "NONE", bold = true, italic = true, underline = true })
	end,
}

local highlighter = {
  "azabiong/vim-highlighter",
  config = function()
    -- make highlights
    keymap("n", "h<cr>", ":Hi +<cr>")

    -- delete highlights
    keymap("n", "h<esc>", ":Hi -<cr>")
    keymap("n", "t<esc>", ":Hi -<cr>")
    keymap("n", "t<bs>", ":Hi clear<cr>")
    keymap("n", "h<bs>", ":Hi clear<cr>")

    -- match closest next highlight
    keymap("n", "`", ":Hi }<cr>zz")
    keymap("n", "|", ":Hi {<cr>zz")

    -- highlights import and save
    keymap("n", "hih", ":Hi load <tab><cr>")
    keymap("n", "his", ":Hi save <tab><cr>")
    keymap("n", "hil", ":Hi ls<cr>")
  end,
}

local nnn = {
	"luukvbaal/nnn.nvim",
    keys = { { "hn", ":NnnPicker %:p:h<CR>", desc = "Open Nnn" } },
	opts = {
		quitcd = "tcd",
		set_hidden = true,
		session = "shared",
		auto_close = true,
	},
}

-- git manager
local fugitive = {
	"tpope/vim-fugitive",
	config = function()
		-- HAsh & Harvest into HASH HOUSE
		keymap("n", "hg", ":G<cr>:only<CR>", { desc = "git status" }) --top overview
		keymap("n", "haf", ":G blame", { desc = "git blame" }) -- fault
		keymap("n", "har", ":Git log<cr>", { desc = "git blame" }) -- use this to see commits and rebase
		keymap("n", "has", ":G stash list<CR>", { desc = "stash show" })
		keymap("n", "hap", ":Gvdiffsplit HEAD~1<cr>", { desc = "git diff" }) -- index to previous commit
    keymap("n", "had", ":Gvdiffsplit", { desc = "merge conflicts" }) -- index to working
	end,
}

local md_render = {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    render_modes =  { "n", "c", "t", "i" },
    heading = { render_modes = true, sign = false},
    code = {render_modes = true, sign = false },
    quote = { render_modes = true},
    bullet = { render_modes = true},
    link = { render_modes = true},
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)
    local colors = { "#DCD7A0", "#FFA500", "#FF6347", "#9370DB", "#1E90FF", "#00CED1" }

		for i, c in ipairs(colors) do
			local style_opts = { fg = c, bold = true }

			if i == 1 then
				style_opts.fg = "#444444"
				style_opts.bg = c
			end

			hl(0, "RenderMarkdownH" .. i, style_opts)
			hl(0, "RenderMarkdownH" .. i .. "Bg", style_opts)
		end
	end,
}

local vimbetter = {"szymonwilczek/vim-be-better"}

return { colorscheme, nnn, md_render, vimbetter, fugitive, highlighter}
