local colorscheme = {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd("colorscheme nightfox")
    vim.api.nvim_set_hl(0, "MiniJump", { fg = "#d3b3b3", bold = true, underline = false, italic = true })
  end,
}

local full = {
  "propet/toggle-fullscreen.nvim",
  keys = {
    {
      "<leader>f",
      function()
        require("toggle-fullscreen"):toggle_fullscreen()
      end,
      desc = "toggle-fullscreen"
    },
  },
}

local nnn = {
  "luukvbaal/nnn.nvim",
  keys = { { "<leader>e", ":NnnPicker %:p:h<CR>", desc = "Open Nnn" } },
  opts = {
    quitcd = "tcd",
    set_hidden = true,
    session = "shared",
    auto_close = true,
  },
}

local vimdiesel = { "ThePrimeagen/vim-be-good", }

local md_render = {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    render_modes = { "n", "c", "t", "i" },
    heading = { signs = { "󰫎 ", "", "", "", "", "" } },
    code = { sign = false },
    bullet = { icons = { "•", "▹", "▪", "⋄" } },
  },
}

local fugitive = {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gm", ":G<cr>:only<CR>", { desc = "Open Fugitive" })
  end,
}
-- git manager

-- MARKDOWN HEADING HIGHLIGHTS
vim.cmd([[highlight RenderMarkdownH1 guifg=#FFD700 gui=bold]])
vim.cmd([[highlight RenderMarkdownH2 guifg=#FFA500 gui=bold]])
vim.cmd([[highlight RenderMarkdownH3 guifg=#FF6347 gui=bold]])
vim.cmd([[highlight RenderMarkdownH4 guifg=#9370DB gui=bold]])
vim.cmd([[highlight RenderMarkdownH5 guifg=#1E90FF gui=bold]])
vim.cmd([[highlight RenderMarkdownH6 guifg=#00CED1 gui=bold]])
vim.cmd([[highlight RenderMarkdownH1Bg guifg=#FFD700 gui=bold]])
vim.cmd([[highlight RenderMarkdownH2Bg guifg=#FFA500 gui=bold]])
vim.cmd([[highlight RenderMarkdownH3Bg guifg=#FF6347 gui=bold]])
vim.cmd([[highlight RenderMarkdownH4Bg guifg=#9370DB gui=bold]])
vim.cmd([[highlight RenderMarkdownH5Bg guifg=#1E90FF gui=bold]])
vim.cmd([[highlight RenderMarkdownH6Bg guifg=#00CED1 gui=bold]])

return { colorscheme, nnn, md_render, vimdiesel, fugitive, full }
