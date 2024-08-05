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
    keymap("n", "<leader>fs", "<cmd>Telescope grep_string<cr>")
    keymap("n", "<leader>fl", "<cmd>Telescope live_grep<cr>")
    keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
    keymap("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>")
    keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>")
    keymap("n", "<leader>fN", "<cmd>Telescope find_files cwd=~/Documents/notes/<cr>")
  end,
}
