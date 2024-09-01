return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    local keymap = vim.keymap.set
    harpoon:setup()

    keymap("n", "<leader>a", function()
      harpoon:list():add()
    end)

    keymap("n", "<leader>h", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    for _, idx in ipairs({ 1, 2, 3, 4, 5 }) do
      keymap("n", string.format("<space>%d", idx), function()
        harpoon:list():select(idx)
      end)
    end
  end,
}
