return {
  "tpope/vim-fugitive",
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
      local keymap = vim.keymap.set
      keymap("n", "<leader>hp", ":Gitsigns preview_hunk<CR>")
    end,
  },
}
