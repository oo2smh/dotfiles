return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "debugloop/telescope-undo.nvim",
    -- also downloaded ripgrep & fd (:checkhealth telescope)
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")
    telescope.load_extension("fzf")
    require("telescope").load_extension("undo")

    telescope.setup({
      defaults = {
        file_ignore_patterns = {
          "node_modules",
          "undodir",
          ".git",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        }
      }
    })

    local keymap = vim.keymap.set
    keymap("n", "<leader>ff", "<cmd>Telescope find_files cwd=~/Dev/<cr>")
    keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")

    keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
    keymap("n", "<leader>fr", "<cmd>Telescope registers<cr>")
    keymap("n", "<leader>fD", "<cmd>Telescope diagnostics<cr>")
    keymap("n", "<leader>fs", builtin.lsp_document_symbols)
    keymap("n", "<leader>fu", "<cmd>Telescope undo<cr>")
    keymap("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")
    keymap("n", "<leader>gz", "<cmd>Telescope git_stash<cr>")
    keymap("n", "<leader>gB", ":G blame<CR>")
  end
}
