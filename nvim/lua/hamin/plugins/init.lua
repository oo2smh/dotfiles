return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,

    config = function()
      require("tokyonight").setup({
        on_colors = function(colors)
          colors.bg = "#000005"
        end,
      })

      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  "tpope/vim-fugitive",
  "nvim-lua/plenary.nvim",
  {
    "echasnovski/mini.pairs",
    version = false,
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.statusline",
    version = false,
    config = function()
      require("mini.statusline").setup()
    end,
  },
  {
    "echasnovski/mini.basics",
    version = false,
    config = function()
      require("mini.basics").setup()
    end,
  }
}
