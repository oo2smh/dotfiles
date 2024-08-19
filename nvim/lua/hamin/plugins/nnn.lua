return {
  "luukvbaal/nnn.nvim",
  -- replace_netrw = "picker",
  config = function()
    require("nnn").setup({
      explorer = {
        cmd = "nnn",
        width = 36,
        side = "botright",
        session = "shared",
      },
      auto_open = {
        setup = "picker",
        tabpage = "explorer",
      },
      quitcd = "cd",
    })
    local keymap = vim.keymap.set
    keymap("n", "<leader>e", ":NnnExplorer %:p:h<CR>")
  end,
}
