local autocmd = vim.api.nvim_create_autocmd
local formatoptions = vim.opt_local.formatoptions

-- PREVENT AUTO COMMENTING NEXT LINES

autocmd("FileType", {
  pattern = "*",
  callback = function()
    formatoptions:remove({ "r", "o" })
  end,
})

autocmd("FileType", {
  pattern = "-",
  callback = function()
    formatoptions:remove({ "r", "o" })
  end,
})


-- REMOVE TRAILING WHITESPACE
autocmd({"BufWritePre"}, {
  pattern = {"*"},
  command = [[%s/\s\+$//e]],
})
