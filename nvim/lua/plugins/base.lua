local keymap = vim.keymap.set
local cmd = vim.cmd

local colorscheme = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		cmd("colorscheme duskfox")
    local set_hl = vim.api.nvim_set_hl
		set_hl(0, "CursorLineNr", { fg = "#FFFFFF", bg = "#4050C0", bold = true, italic = true })
		set_hl(0, "CursorLine", {bg = "#454545"})
		set_hl(0, "Visual", { bg = "#6040B0", italic = true })
      set_hl(0, "MatchParen", { fg = "#fff44f", bold = true, italic = true, underline = true })
		set_hl(0, "Search", { bg = "#944475", bold = true, italic = true })
		set_hl(0, "MiniCursorWord", { bg = "NONE", bold = true, italic = true, underline = true })
	end,
}

local highlighter = {
  "azabiong/vim-highlighter",
  config = function()

--[[
:HI/Find: Used to search other files. It will not use the current position to search. When you press next, it will most likely search another file. Use global H mark to mark current location. And then while scrolling, return back to base with another keybind. It will pollute the open buffers list

with the filtered list: use r to make it bigger, v to
  ]]

    -- find and mark project wide
    keymap("n", "h<tab>", function()
      -- mark current position as H
      cmd("normal! mH")
      -- run :Hi/Find with current word
      local word = vim.fn.expand("<cword>")
      local current_buffer = vim.fn.expand("%:t")
      cmd("Hi/Find " .. word)
      cmd("norm! /" .. current_buffer)
    end)

    -- make highlights
    keymap("n", "h<cr>", ":Hi +<cr>")

    -- delete highlights
    keymap("n", "h<esc>", ":Hi -<cr>")
    keymap("n", "t<esc>", ":Hi -<cr>")
    keymap("n", "f<bs>", ":Hi //<cr>") -- clears hi/find highlights
    keymap("n", "t<bs>", ":Hi clear<cr>")
    keymap("n", "h<bs>", ":Hi clear<cr>")

    -- match closest next highlight
    keymap("n", "`", ":Hi }<cr>zz")
    keymap("n", "|", ":Hi {<cr>zz")

    -- cycle through project search
    keymap("n", "\\", "'Hzz")
    keymap("n", "l.", ":Hi/older<cr>") -- past find searches
    keymap("n", "l,", ":Hi/newer<cr>")

    -- highlights import and save
    keymap("n", "hih", ":Hi load <tab><cr>")
    keymap("n", "his", ":Hi save <tab><cr>")
    keymap("n", "hil", ":Hi ls<cr>")
  end,
}

local full = {
  "propet/toggle-fullscreen.nvim",
  config = function() end,
  keys = {
    {
      "<leader>f",
      function()
        require("toggle-fullscreen"):toggle_fullscreen()
      end,
      desc = "Toggle fullscreen",
    },
  },
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
		keymap("n", "haf", ":Gblame", { desc = "git blame" }) -- fault
		keymap("n", "har", ":Git log<cr>", { desc = "git blame" }) -- use this to see commits and rebase
		keymap("n", "has", ":G stash list<CR>", { desc = "stash show" })
		keymap("n", "hap", ":Gvdiffsplit HEAD~1<cr>", { desc = "git diff" }) -- index to previous commit
    keymap("n", "had", ":Gvdiffsplit", { desc = "merge conflicts" }) -- index to working
	end,
}

local md_render = {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		render_modes = { "n", "c", "t", "i" },
		heading = { signs = { "󰫎 ", "", "", "", "", "" } },
		code = { sign = false },
		bullet = { icons = { "•", "▹", "▪", "⋄" } },
	},

	config = function()
		local colors = { "#DCD7A0", "#FFA500", "#FF6347", "#9370DB", "#1E90FF", "#00CED1" }
		local set_hl = vim.api.nvim_set_hl

		for i, c in ipairs(colors) do
			local style_opts = { fg = c, bold = true }

			if i == 1 then
				style_opts.fg = "Black"
				style_opts.bg = c
			end

			if i == 2 then style_opts.underline = false end

			set_hl(0, "RenderMarkdownH" .. i,  style_opts)
			set_hl(0, "RenderMarkdownH" .. i .. "Bg", style_opts)
		end
	end,
}

local vimbetter = {"szymonwilczek/vim-be-better"}

keymap("n", "<leader>|", ":VimBeBetter<Cr>")


return { colorscheme, nnn, md_render, vimbetter, fugitive, full, highlighter}
