local group = vim.api.nvim_create_augroup("main", { clear = true })

--PREVENT AUTO COMMENTING NEXT LINES
autocmd("FileType", {
  group = group,
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- REMOVE TRAILING WHITESPACE
autocmd("BufWritePre", { group = group, command = [[%s/\s\+$//e]] })

-- OPEN HELP IN VERTICAL SPLIT
autocmd("FileType", { group = group, pattern = "help", command = "wincmd L"})

-- RESTORE CURSOR TO FILE POSITION IN PREVIOUS EDITING SESSION
autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)

      -- Defer centering slightly so it's applied after render
      vim.schedule(function()
        cmd("normal! zz")
      end)
    end
  end,
})

-- SHOW CURSORLINE ONLY IN THE ACTIVE WINDOW: ENABLE
autocmd({ "WinEnter", "BufEnter", "WinLeave", "BufLeave" }, {
  group = group,
  callback = function(args)
    local active = (args.event == "WinEnter" or args.event == "BufEnter")
    vim.opt_local.cursorline = active
  end,
})

-- TREESITTER AUTOSTART auto-start treesitter for certain filetypes
local languages = { "markdown", "markdown-inline", "python", "yaml", "javascript", "c" }
for _, lang in ipairs(languages) do
    autocmd("FileType", {
      group = group,
        pattern = lang,
        callback = function()
            vim.treesitter.start() -- highlights
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"  -- indents
        end,
    })
end

-- MARKDOWN ONLY
autocmd("FileType", {
  group = group,
  pattern = "markdown",
  callback = function()
    o.spellcapcheck = "" -- disable cap check for spell check
    o.conceallevel = 2
  end,
})
