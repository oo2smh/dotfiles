local M = {}
local pick = require("mini.pick")
local fullscreen = false
local ns = vim.api.nvim_create_namespace("side_signs")
local mark_chars = { "a", "h", "t", "m", "w", "A", "E", "I", "C" }

------------------------------------------------
-- GENERAL
------------------------------------------------
M.execute_action = function(type)
  local ft = vim.bo.filetype
  local actions = {
    run = {
      javascript = "node %",
      python     = "python %",
      lua        = "lua %",
      go         = "go run %",
    },
    test = {
      javascript = "npm test -- %",
      typescript = "npx jest -- %",
      python     = "pytest %",
      go         = "go test -v %",
    }
  }

  local command = (actions[type] or {})[ft]
  if command then
    vim.cmd("vsplit | term " .. command)
  else
    vim.notify("No " .. type .. " defined for " .. ft, 3)
  end
end

M.open_root_file = function(filename)
  local git_dir = vim.fn.finddir(".git", ".;")

  if git_dir == "" then
    vim.notify(filename .. " doesn't exist in the git project", vim.log.levels.WARN)
    return
  end
  local root_path = vim.fn.fnamemodify(git_dir, ":h")
  local file_path = root_path .. "/" .. filename

  if vim.fn.filereadable(file_path) == 0 then
    vim.notify(filename .. " doesn't exist in the project root", vim.log.levels.WARN)
    return
  end

  cmd("edit " .. vim.fn.fnameescape(file_path))
end


M.centered_act = function(command, letter)
  letter = letter or ""
  return command .. letter .. "zz"
end

M.toggle_fullscreen = function()
  if not fullscreen then cmd("wincmd |") cmd("wincmd _") else cmd("wincmd =") end
  fullscreen = not fullscreen
end

------------------------------------------------
-- SHOW MARKS
------------------------------------------------
M.update_mark_signs = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  for _, char in ipairs(mark_chars) do
    local mark = vim.api.nvim_buf_get_mark(bufnr, char)
    local row = mark[1] - 1

    if row >= 0 then
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, 0, {
        sign_text = char,
        sign_hl_group = "Statement",
        priority = 1,
      })
    end
  end
  vim.opt_local.signcolumn = "yes"
  vim.cmd("redraw")
end

local function set_mark_and_update()
  local ok, char = pcall(vim.fn.getcharstr)
  if not ok or char == "\27" then return end -- Handle <Esc> or errors
  vim.cmd("normal! m" .. char)
  M.update_mark_signs()
end

local function del_mark_at_line_and_update()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local found = false

  -- Iterate through your defined mark_chars to find one on this line
  for _, char in ipairs(mark_chars) do
    local mark = vim.api.nvim_buf_get_mark(bufnr, char)
    if mark[1] == cursor_line then
      vim.cmd("delmarks " .. char)
      found = true
    end
  end

  if found then
    M.update_mark_signs()
  else
    vim.notify("No mark found on current line", vim.log.levels.INFO)
  end
end

------------------------------------------------
-- MINI PICKERS
------------------------------------------------
M.check_health = function()
  local items = {
    "mason-lspconfig",
    "nvim-treesitter",
    "render-markdown",
    "vim.deprecated",
    "vim.health",
    "vim.lsp",
    "vim.pack",
    "vim.provider",
    "vim.treesitter"
  }

  pick.start({
    source = {
      items = items,
      name = 'Checkhealth',
      choose = function(item)
        vim.cmd('vert checkhealth ' .. item)
      end,
    },
  })
end

M.git_branch_switch = function()
  local branches = vim.fn.systemlist("git branch --format='%(HEAD) %(worktreepath) %(refname:short)'")

  for i, line in ipairs(branches) do
    local is_head, path, name = line:match("([* ])%s*(.-)%s+([^%s]+)$")
    local prefix = "  "
    if is_head == "*" then prefix = "* "
    elseif path ~= "" then prefix = "+ "
    end
    branches[i] = prefix .. name
  end

  pick.start({
    source = { items = branches, name = "Git branches",
    choose = function(item)
      local branch_to_switch = item:sub(3)
      vim.fn.system({ "git", "switch", branch_to_switch })
      cmd("checktime")
    end,
  },
})
end
------------------------------------------------
-- BOOKMARKER
------------------------------------------------
local ns_id = vim.api.nvim_create_namespace("LineHighlighter")
hl(0, "FirstCharMark", { fg = "#FFCC00" })

local function redraw(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local path = vim.api.nvim_buf_get_name(bufnr)
    local data = vim.g.MARKER_DATA or {}

    vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    if not data[path] then return end

    local total_lines = vim.api.nvim_buf_line_count(bufnr)
    for row_str, _ in pairs(data[path]) do
        local row = tonumber(row_str)
        if row and row < total_lines then
            vim.api.nvim_buf_set_extmark(bufnr, ns_id, row, 0, {
                number_hl_group = "FirstCharMark",
                priority = 1000,
            })
        end
    end
end
local function toggle_bookmark()
    local path = vim.api.nvim_buf_get_name(0)
    if path == "" then return end
    local row = tostring(vim.api.nvim_win_get_cursor(0)[1] - 1)

    -- Force deep copy to break Lua/Vimscript proxy issues
    local data = vim.deepcopy(vim.g.MARKER_DATA or {})
    data[path] = data[path] or {}

    if data[path][row] then
        data[path][row] = nil
    else
        data[path][row] = true
    end

    vim.g.MARKER_DATA = data
    redraw(0)
end

local function clear_bookmarks()
    local path = vim.api.nvim_buf_get_name(0)
    local data = vim.deepcopy(vim.g.MARKER_DATA or {})
    data[path] = nil
    vim.g.MARKER_DATA = data
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
    print("Marks cleared")
end

-- local function jump_bookmarks(dir)
--     local marks = vim.api.nvim_buf_get_extmarks(0, ns_id, 0, -1, {})
--     if #marks == 0 then return end
--     local row = vim.api.nvim_win_get_cursor(0)[1] - 1
--     table.sort(marks, function(a, b) return a[2] < b[2] end)
--     for _, m in ipairs(marks) do
--         if (dir > 0 and m[2] > row) or (dir < 0 and m[2] < row) then
--             vim.api.nvim_win_set_cursor(0, { m[2] + 1, 0 })
--             return
--         end
--     end
--     local t = dir > 0 and marks[1] or marks[#marks]
--     vim.api.nvim_win_set_cursor(0, { t[2] + 1, 0 })
-- end

local function jump_bookmarks(dir)
    local marks = vim.api.nvim_buf_get_extmarks(0, ns_id, 0, -1, {})
    if #marks == 0 then return end

    local row = vim.api.nvim_win_get_cursor(0)[1] - 1
    table.sort(marks, function(a, b) return a[2] < b[2] end)

    if dir > 0 then
        -- Forward: Find the first mark after the cursor
        for _, m in ipairs(marks) do
            if m[2] > row then
                vim.api.nvim_win_set_cursor(0, { m[2] + 1, 0 })
                return
            end
        end
        vim.api.nvim_win_set_cursor(0, { marks[1][2] + 1, 0 }) -- Wrap to start
    else
        -- Backward: Iterate in reverse to find the first mark before the cursor
        for i = #marks, 1, -1 do
            local m = marks[i]
            if m[2] < row then
                vim.api.nvim_win_set_cursor(0, { m[2] + 1, 0 })
                return
            end
        end
        vim.api.nvim_win_set_cursor(0, { marks[#marks][2] + 1, 0 }) -- Wrap to end
    end
end


autocmd({ "BufWinEnter", "SessionLoadPost" }, { callback = function(ev) redraw(ev.buf) end })

-- Mappings
keymap('n', 'm-', toggle_bookmark) -- make mark
keymap('n', 'mn', function() jump_bookmarks(1) cmd("norm zz") end)
keymap('n', 'mi', function() jump_bookmarks(-1) cmd("norm zz") end) -- use altrep key
keymap('n', 'm<BS>', clear_bookmarks)
keymap("n", "md", del_mark_at_line_and_update, { desc = "Delete mark and update signs" })
keymap("n", "m", set_mark_and_update, { desc = "Set any mark and update signs", silent = true })
autocmd({ "BufEnter", "SessionLoadPost", "BufWritePre" }, { callback = function() M.update_mark_signs() end, })

keymap('n', '<leader>f', function()
    local winid = vim.api.nvim_get_current_win()
    if vim.wo[winid].foldlevel == 0 then
        vim.cmd('normal! zR') -- Unfold all
    else
        vim.cmd('normal! zM') -- Fold all
    end
end, { desc = "Toggle Fold All" })

return M
