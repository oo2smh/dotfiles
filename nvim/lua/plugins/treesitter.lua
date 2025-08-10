return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag", },
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      highlight        = { enable = true, },
      auto_install     = true,
      indent           = { enable = true },
      autotag          = { enable = true, },

      ensure_installed = { "json", "javascript", "typescript", "toml", "yaml", "html", "css", "python", "markdown", "markdown_inline", "go", "bash", "lua", "vim", "gitignore", "query", "vimdoc", "c", },
    })
  end,
}
