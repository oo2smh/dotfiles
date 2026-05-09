local M = {}
local pick = require("mini.pick")
local fullscreen = false
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
  if not fullscreen then
    cmd("wincmd |")
    cmd("wincmd _")
  else
    cmd("wincmd =")
  end
  fullscreen = not fullscreen
end

------------------------------------------------
-- MINI PICKERS
------------------------------------------------
M.git_branch_switch = function()
  local branches = vim.fn.systemlist("git branch --format='%(HEAD) %(worktreepath) %(refname:short)'")

  for i, line in ipairs(branches) do
    local is_head, path, name = line:match("([* ])%s*(.-)%s+([^%s]+)$")
    local prefix = "  "
    if is_head == "*" then
      prefix = "* "
    elseif path ~= "" then
      prefix = "+ "
    end
    branches[i] = prefix .. name
  end

  pick.start({
    source = {
      items = branches,
      name = "Git branches",
      choose = function(item)
        local branch_to_switch = item:sub(3)
        vim.fn.system({ "git", "switch", branch_to_switch })
        cmd("checktime")
      end,
    },
  })
end

------------------------------------------------
-- TRI-COLOR HIGHLIGHTER
------------------------------------------------
M.ns = vim.api.nvim_create_namespace("InstanceHighlight")
M.highlight_dir = vim.fn.stdpath("data") .. "/highlights"

if vim.fn.isdirectory(M.highlight_dir) == 0 then
  vim.fn.mkdir(M.highlight_dir, "p")
end

vim.cmd([[
  highlight MyCyan   guibg=#00FFFF guifg=#000000
  highlight MyOrange guibg=#FFA500 guifg=#000000
  highlight MyNeon   guibg=#39FF14 guifg=#000000
]])

-- FILE PERSISTENCE
------------------------------------------------
M.file_highlight_path = function(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then return nil end

  local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(path) .. " rev-parse --show-toplevel")[1]
  local base = (git_root and git_root ~= "" and vim.v.shell_error == 0)
      and vim.fn.fnamemodify(git_root, ":t") or "~"

  local safe_name = path:gsub("/", "_")
  return M.highlight_dir .. "/" .. base .. "_" .. safe_name .. ".lua"
end

M.save_highlights = function(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local path = M.file_highlight_path(buf)
  if not path then return end

  -- Scrape current extmarks to save "ground truth" positions
  local marks = vim.api.nvim_buf_get_extmarks(buf, M.ns, 0, -1, { details = true })
  local data = {}
  for _, m in ipairs(marks) do
    table.insert(data, {
      group = m[4].hl_group,
      s_line = m[2],
      s_col = m[3],
      e_line = m[4].end_row,
      e_col = m[4].end_col
    })
  end

  local f = io.open(path, "w")
  if f then
    f:write("return " .. vim.inspect(data))
    f:close()
  end
end

M.load_highlights = function(buf)
  local path = M.file_highlight_path(buf)
  if not path or vim.fn.filereadable(path) ~= 1 then return end
  local ok, data = pcall(dofile, path)
  if ok and type(data) == "table" then
    for _, h in ipairs(data) do
      vim.api.nvim_buf_set_extmark(buf, M.ns, h.s_line, h.s_col, {
        end_row = h.e_line,
        end_col = h.e_col,
        hl_group = h.group,
        invalidate = true -- mark deleted if text is wiped
      })
    end
  end
end

-- CORE ACTIONS
------------------------------------------------
M.toggle_highlight = function(group, s_line, s_col, e_line, e_col)
  local buf = vim.api.nvim_get_current_buf()

  -- Remove existing if exact match found (Toggle)
  local marks = vim.api.nvim_buf_get_extmarks(buf, M.ns, { s_line, s_col }, { e_line, e_col }, { details = true })
  for _, m in ipairs(marks) do
    if m[2] == s_line and m[3] == s_col and m[4].end_row == e_line and m[4].end_col == e_col then
      vim.api.nvim_buf_del_extmark(buf, M.ns, m[1])
      M.save_highlights(buf)
      return
    end
  end

  -- Otherwise, create new extmark
  vim.api.nvim_buf_set_extmark(buf, M.ns, s_line, s_col, {
    end_row = e_line,
    end_col = e_col,
    hl_group = group,
    invalidate = true
  })
  M.save_highlights(buf)
end

M.highlight_word_or_selection = function(group)
  local mode = vim.fn.mode()
  if mode:match("[vV]") then
    local start_pos, end_pos = vim.fn.getpos("v"), vim.fn.getpos(".")
    local s_line, s_col = start_pos[2] - 1, start_pos[3] - 1
    local e_line, e_col = end_pos[2] - 1, end_pos[3] - 1

    if s_line > e_line or (s_line == e_line and s_col > e_col) then
      s_line, e_line = e_line, s_line
      s_col, e_col = e_col, s_col
    end

    if mode == "v" then e_col = e_col + 1 end
    if mode == "V" then
      s_col = 0
      e_col = #vim.api.nvim_buf_get_lines(0, e_line, e_line + 1, false)[1]
    end

    M.toggle_highlight(group, s_line, s_col, e_line, e_col)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
  else
    local word = vim.fn.expand("<cword>")
    if word ~= "" then
      local line = vim.api.nvim_get_current_line()
      local col = line:find(word, 1, true) - 1
      M.toggle_highlight(group, vim.fn.line('.') - 1, col, vim.fn.line('.') - 1, col + #word)
    end
  end
end

M.jump_color = function(group, dir)
  local buf = vim.api.nvim_get_current_buf()
  local marks = vim.api.nvim_buf_get_extmarks(buf, M.ns, 0, -1, { details = true })
  local filtered = vim.tbl_filter(function(m) return m[4].hl_group == group end, marks)

  if #filtered == 0 then return end
  table.sort(filtered, function(a, b) return a[2] < b[2] or (a[2] == b[2] and a[3] < b[3]) end)

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local target
  if dir > 0 then
    for _, m in ipairs(filtered) do
      if m[2] > row or (m[2] == row and m[3] > col) then
        target = m
        break
      end
    end
    target = target or filtered[1]
  else
    for i = #filtered, 1, -1 do
      local m = filtered[i]
      if m[2] < row or (m[2] == row and m[3] < col) then
        target = m
        break
      end
    end
    target = target or filtered[#filtered]
  end

  vim.api.nvim_win_set_cursor(0, { target[2] + 1, target[3] })
  vim.cmd("norm zz")
end

M.clear_highlights = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  M.save_highlights(buf)
end

-- AUTOCOMMANDS
------------------------------------------------
vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter" }, {
  callback = function(ev) M.load_highlights(ev.buf) end
})

local keymap = vim.keymap.set
local opts = { silent = true }

-- Orange
keymap({ "n", "v" }, "!1", function() M.highlight_word_or_selection("MyOrange") end, opts)
keymap("n", "!2", function() M.jump_color("MyOrange", -1) end, opts)
keymap("n", "!3", function() M.jump_color("MyOrange", 1) end, opts)
keymap({ "n", "v" }, "!h", function() M.highlight_word_or_selection("MyOrange") end, opts)
keymap("n", "!t", function() M.jump_color("MyOrange", -1) end, opts)
keymap("n", "!n", function() M.jump_color("MyOrange", 1) end, opts)

-- Neon
keymap({ "n", "v" }, "!4", function() M.highlight_word_or_selection("MyNeon") end, opts)
keymap("n", "!5", function() M.jump_color("MyNeon", -1) end, opts)
keymap("n", "!6", function() M.jump_color("MyNeon", 1) end, opts)
keymap({ "n", "v" }, "!m", function() M.highlight_word_or_selection("MyNeon") end, opts)
keymap("n", "!g", function() M.jump_color("MyNeon", -1) end, opts)
keymap("n", "!w", function() M.jump_color("MyNeon", 1) end, opts)

-- Cyan
keymap({ "n", "v" }, "!7", function() M.highlight_word_or_selection("MyCyan") end, opts)
keymap("n", "!8", function() M.jump_color("MyCyan", -1) end, opts)
keymap("n", "!9", function() M.jump_color("MyCyan", 1) end, opts)
keymap({ "n", "v" }, "!l", function() M.highlight_word_or_selection("MyCyan") end, opts)
keymap("n", "!d", function() M.jump_color("MyCyan", -1) end, opts)
keymap("n", "!p", function() M.jump_color("MyCyan", 1) end, opts)

-- Utilities
-- Note: M.toggle_visibility must be defined in your M table for this to work
if M.toggle_visibility then
  keymap("n", "<leader>h", function() M.toggle_visibility() end, opts)
end

keymap("n", "h<bs>", function() M.clear_highlights() end, opts)

return M
