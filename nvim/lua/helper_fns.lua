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
  if not fullscreen then cmd("wincmd |") cmd("wincmd _") else cmd("wincmd =") end
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
-- TRI-COLOR HIGHLIGHTER
------------------------------------------------
M.ns = vim.api.nvim_create_namespace("InstanceHighlight")
M.highlight_dir = vim.fn.stdpath("data") .. "/highlights"

-- Ensure folder exists
if vim.fn.isdirectory(M.highlight_dir) == 0 then
  vim.fn.mkdir(M.highlight_dir, "p")
end

-- Highlight groups (plain colors)
vim.cmd([[
  highlight MyCyan   guibg=#00FFFF guifg=#000000
  highlight MyOrange guibg=#FFA500 guifg=#000000
  highlight MyNeon   guibg=#39FF14 guifg=#000000
]])

M.highlights = {}

M.file_highlight_path = function(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then return nil end

  -- Determine base folder
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.fnameescape(path) .. " rev-parse --show-toplevel")[1]
  local base
  if git_root and git_root ~= "" and vim.v.shell_error == 0 then
    -- Use the git root folder name
    base = vim.fn.fnamemodify(git_root, ":t")
    -- Make path relative to git root
    path = vim.fn.fnamemodify(path, ":." .. git_root)
  else
    -- fallback to home
    local home = vim.fn.expand("~")
    base = "~"
    path = path:gsub("^" .. home .. "/", "")
  end

  local safe_name = path:gsub("/", "_")
  return M.highlight_dir .. "/" .. base .. "_" .. safe_name
end
-- Load highlights for a buffer
M.load_highlights = function(buf)
  local path = M.file_highlight_path(buf)
  if not path or vim.fn.filereadable(path) ~= 1 then return {} end
  local ok, data = pcall(dofile, path)
  if ok and type(data) == "table" then return data end
  return {}
end

-- Save highlights for a buffer
M.save_highlights = function(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local path = M.file_highlight_path(buf)
  if not path then return end
  local f = io.open(path, "w")
  if f then
    f:write("return " .. vim.inspect(M.highlights[buf] or {}))
    f:close()
  end
end

-- Toggle highlight (removes overlapping, applies new color)
M.toggle_highlight = function(group, s_line, s_col, e_line, e_col)
  local buf = vim.api.nvim_get_current_buf()
  M.highlights[buf] = M.highlights[buf] or {}

  local remove_existing = false
  local new_hl = {}

  for _, h in ipairs(M.highlights[buf]) do
    local overlap = not (h.e_col <= s_col and h.s_line == s_line or
                        h.s_line < s_line or
                        h.s_col >= e_col and h.s_line == e_line or
                        h.s_line > e_line)

    if overlap then
      if h.group == group then
        remove_existing = true  -- same color exists → remove it
      end
      -- different color → remove it, do not add
    else
      table.insert(new_hl, h)
    end
  end

  M.highlights[buf] = new_hl

  -- Apply new highlight if no same-color highlight existed
  if not remove_existing then
    for l = s_line, e_line do
      local startc = (l == s_line) and s_col or 0
      local endc = (l == e_line) and e_col or vim.api.nvim_buf_get_lines(buf, l, l+1, false)[1]:len()
      table.insert(M.highlights[buf], {group=group, s_line=l, s_col=startc, e_col=endc})
    end
  end

  -- Refresh buffer
  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  for _, h in ipairs(M.highlights[buf]) do
    vim.api.nvim_buf_add_highlight(buf, M.ns, h.group, h.s_line, h.s_col, h.e_col)
  end

  M.save_highlights(buf)
end

-- Highlight word or selection
M.highlight_word_or_selection = function(group)
  local mode = vim.fn.mode()
  if mode == "v" or mode == "V" then
    local start_pos = vim.fn.getpos("v")
    local end_pos   = vim.fn.getpos(".")
    local s_line, s_col = start_pos[2]-1, start_pos[3]-1
    local e_line, e_col = end_pos[2]-1, end_pos[3]-1

    if s_line > e_line or (s_line == e_line and s_col > e_col) then
      s_line, e_line = e_line, s_line
      s_col, e_col = e_col, s_col
    end

    if mode == "v" then e_col = e_col + 1 end

    -- Visual Line mode: highlight full lines
    if mode == "V" then
      for l = s_line, e_line do
        local line_len = vim.api.nvim_buf_get_lines(0,l,l+1,false)[1]:len()
        M.toggle_highlight(group, l, 0, l, line_len)
      end
    else
      M.toggle_highlight(group, s_line, s_col, e_line, e_col)
    end

    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
  else
    local word = vim.fn.expand("<cword>")
    if word ~= "" then
      local line = vim.api.nvim_get_current_line()
      local col = string.find(line, word, 1, true)-1
      M.toggle_highlight(group, vim.fn.line('.')-1, col, vim.fn.line('.')-1, col+#word)
    end
  end
end

-- Apply highlights to buffer
M.apply_highlights = function(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  if not M.highlights[buf] then return end
  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  for _, h in ipairs(M.highlights[buf]) do
    vim.api.nvim_buf_add_highlight(buf, M.ns, h.group, h.s_line, h.s_col, h.e_col)
  end
end

-- Toggle visibility
local highlights_visible = true
M.toggle_visibility = function()
  local buf = vim.api.nvim_get_current_buf()
  if highlights_visible then
    vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
    highlights_visible = false
  else
    M.apply_highlights(buf)
    highlights_visible = true
  end
end

-- Clear all highlights
M.clear_highlights = function()
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buf, M.ns, 0, -1)
  M.highlights[buf] = nil
  M.save_highlights(buf)
end

-- Jump between orange highlights only
M.jump_color = function(group, dir)
  local buf = vim.api.nvim_get_current_buf()
  local hl = M.highlights[buf]
  if not hl or #hl == 0 then return end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1

  local filtered = {}
  for _, h in ipairs(hl) do
    if h.group == group then table.insert(filtered, h) end
  end
  if #filtered == 0 then return end

  table.sort(filtered, function(a,b) return a.s_line < b.s_line end)

  if dir > 0 then
    for _, h in ipairs(filtered) do
      if h.s_line > row or (h.s_line == row and h.s_col > col) then
        vim.api.nvim_win_set_cursor(0, {h.s_line+1, h.s_col})
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, {filtered[1].s_line+1, filtered[1].s_col})
  else
    for i=#filtered,1,-1 do
      local h = filtered[i]
      if h.s_line < row or (h.s_line == row and h.s_col < col) then
        vim.api.nvim_win_set_cursor(0, {h.s_line+1, h.s_col})
        return
      end
    end
    vim.api.nvim_win_set_cursor(0, {filtered[#filtered].s_line+1, filtered[#filtered].s_col})
  end

  cmd("norm zz")
end

-- Auto-load highlights per buffer
autocmd({"BufReadPost", "BufEnter"}, {
  callback = function(ev)
    M.highlights[ev.buf] = M.load_highlights(ev.buf)
    M.apply_highlights(ev.buf)
  end
})

keymap({"n","v"}, "!1", function() M.highlight_word_or_selection("MyOrange") end, {silent=true})
keymap("n", "!2", function() M.jump_color("MyOrange", -1) end, {silent=true})
keymap("n", "!3", function() M.jump_color("MyOrange", 1) end, {silent=true})
keymap({"n","v"}, "!4", function() M.highlight_word_or_selection("MyNeon") end, {silent=true})
keymap("n", "!5", function() M.jump_color("MyNeon", -1) end, {silent=true})
keymap("n", "!6", function() M.jump_color("MyNeon", 1) end, {silent=true})
keymap({"n","v"}, "!7", function() M.highlight_word_or_selection("MyCyan") end, {silent=true})
keymap("n", "!8", function() M.jump_color("MyCyan", -1) end, {silent=true})
keymap("n", "!9", function() M.jump_color("MyCyan", 1) end, {silent=true})

keymap({"n","v"}, "!h", function() M.highlight_word_or_selection("MyOrange") end, {silent=true})
keymap("n", "!t", function() M.jump_color("MyOrange", -1) end, {silent=true})
keymap("n", "!n", function() M.jump_color("MyOrange", 1) end, {silent=true})
keymap({"n","v"}, "!m", function() M.highlight_word_or_selection("MyNeon") end, {silent=true})
keymap("n", "!g", function() M.jump_color("MyNeon", -1) end, {silent=true})
keymap("n", "!w", function() M.jump_color("MyNeon", 1) end, {silent=true})
keymap({"n","v"}, "!l", function() M.highlight_word_or_selection("MyCyan") end, {silent=true})
keymap("n", "!d", function() M.jump_color("MyCyan", -1) end, {silent=true})
keymap("n", "!p", function() M.jump_color("MyCyan", 1) end, {silent=true})

keymap("n", "<leader>h", M.toggle_visibility, {silent=true}) -- toggle visibility
keymap("n", "h<bs>", M.clear_highlights, {silent=true})     -- clear all highlights

return M
