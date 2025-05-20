local hardmode = {
	"m4xshen/hardtime.nvim",
	lazy = false,

	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		disable_mouse = false,
		restricted_keys = {
			["<Up>"] = { "n", "x" },
			["<Down>"] = { "n", "x" },
			["<Right>"] = { "n", "x" },
			["<Left>"] = { "n", "x" },
		},
		disabled_keys = {
			["<Up>"] = false,
			["<Down>"] = false,
			["<Right>"] = false,
			["<Left>"] = false,
		},
	},
}

local vimdiesel = {
	"ThePrimeagen/vim-be-good",
}

return { hardmode, vimdiesel }
