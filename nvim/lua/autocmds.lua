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

-- open help in vertical split
autocmd("FileType", { group = group, pattern = "help", command = "wincmd L"})


-- AUTO-ENTER INSERT MODE WHEN ENTERING TERMINAL
autocmd({ "TermOpen", "BufEnter" }, {
    group = group,
    pattern = "*",
    callback = function()
        if vim.bo.buftype == "terminal" then
            vim.cmd("startinsert")
        end
    end,
})

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
autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

-- SHOW CURSORLINE ONLY IN THE ACTIVE WINDOW: DISABLE
autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})

-- RENDER MARKDOWN STYLING
autocmd("FileType", {
  group = group,
  pattern = { "markdown" },
  callback = function()
    local ok, render_md = pcall(require, "render-markdown")
    if not ok then return end

    -- Plugin setup
    render_md.setup({
      render_modes = { "n", "c", "t", "i" },
      heading = { render_modes = true, sign = false },
      code = { render_modes = true, sign = false },
      quote = { render_modes = true },
      bullet = { render_modes = true, icons = {"•", "‣", "▪", "✧"} },
      link = { render_modes = true },
        pipe_table = { render_modes = true },
      inline_highlight = {render_modes = true }
    })

    -- Highlights
    hl(0, "RenderMarkdownH1Bg", { fg = "#444444", bg = "#DCD7A0", bold = true })
    hl(0, "RenderMarkdownH2Bg", { fg = "#FFA500", bold = true })
    hl(0, "RenderMarkdownH3Bg", { fg = "#FF6347", bold = true })
    hl(0, "RenderMarkdownH4Bg", { fg = "#9370DB", bold = true })
    hl(0, "RenderMarkdownH5Bg", { fg = "#1E90FF", bold = true })
    hl(0, "RenderMarkdownH6Bg", { fg = "#00CED1", bold = true })
  end,
})

-- TREESITTER autostart
-- Auto-start treesitter for certain filetypes
local languages = { "markdown", "markdown-inline", "python", "lua", "yaml", "javascript", "c" }
for _, lang in ipairs(languages) do
    autocmd("FileType", {
        pattern = lang,
        callback = function()
            vim.treesitter.start()
        end,
    })
end
