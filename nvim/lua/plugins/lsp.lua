-- LSP CONFIG AND MASON
local lspconfig = { "neovim/nvim-lspconfig", lazy = false }
local mason = { "williamboman/mason.nvim", config = true }

local nvim_java = {
  "nvim-java/nvim-java",
  lazy = true,
  config = function()
    require("lspconfig").jdtls.setup({})
  end,
}

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

-- BLINK COMPLETION ENGINE
local blink = {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "1.*",

  opts = {
    keymap = { preset = "super-tab" },

    completion = { documentation = { auto_show = false } },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}

-- LAZY DEV: Remove global vim api warning:
local lazydev = {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
  },
}

return { nvim_java, lspconfig, mason, mason_lspconfig, blink, lazydev }
