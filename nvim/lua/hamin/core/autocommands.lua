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
autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

--[[
- Code autostarts nnn on nvim startup.
- Disabled b/c I like using : (ex cmds) that's available in netrwc

 if vim.fn.argc(-1) == 0 then
   vim.defer_fn(
    function()
       vim.cmd('NnnPicker')
     end,
     0)
 end
--]]
