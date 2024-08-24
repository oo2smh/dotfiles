return {
  "luukvbaal/nnn.nvim",
  -- replace_netrw = "picker",
  config = function()
    require("nnn").setup({
      picker = {
        session = "shared",
        border = "rounded",
      },
      quitcd = "cd",
    })
    local keymap = vim.keymap.set
    keymap("n", "<leader>e", ":NnnPicker %:p:h<CR>")
  end,
}
