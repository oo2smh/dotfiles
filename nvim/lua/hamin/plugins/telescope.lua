return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local telescope = require("telescope")
    telescope.load_extension("fzf")
    local keymap = vim.keymap.set

    keymap("n", "<leader>ff", "<cmd>Telescope oldfiles<cr>")
    keymap("n", "<leader>fb", "<cmd>Telescope buffers")
    keymap("n", "<leader>fd", "<cmd>Telescope diagnostics")
    keymap("n", "<leader>fm", "<cmd>Telescope marks")
    keymap("n", "<leader>fN", "<cmd>Telescope find_files cwd=~/Documents/notes/<cr>")
  end,
}
