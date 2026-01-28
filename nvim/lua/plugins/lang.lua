-- LSP CONFIG AND MASON
local lspconfig = { "neovim/nvim-lspconfig", lazy = false}
local vim_error = { "folke/lazydev.nvim", ft = "lua", opts = {} }
local mason = { "williamboman/mason.nvim", config = true }

local mason_lspconfig = {
	"williamboman/mason-lspconfig.nvim",
	dependencies = "williamboman/mason.nvim",
	opts = {
		ensure_installed = { "lua_ls", "vimls" },
		automatic_installation = true,
		indent = true,
	},
	workspace = {
		library = vim.api.nvim_get_runtime_file("", true),
	},
}

local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" }, -- autocloses HTML tags
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    local languages = { "markdown", "python", "lua", "vim", "vimdoc", "yaml", "javascript", "c"}
    ts.install(languages)

    -- auto highlight these languages
    for _, lang in ipairs(languages) do
      vim.api.nvim_create_autocmd("FileType", {
        pattern = lang,
        callback = function() vim.treesitter.start() end,
      })
    end
  end,
}

-- SQL specific plugins
	-- "tpope/vim-dadbod",
	-- "kristijanhusak/vim-dadbod-ui",

return { lspconfig, vim_error, mason, mason_lspconfig, treesitter}
