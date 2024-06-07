return {
  {
    "mbbill/undotree",
    config = function()
      local keymap = vim.keymap.set
      keymap("n", "<leader>u", "<cmd>UndotreeToggle<cr>")
    end,
  }
}
