local M = {}

M.add_buffer_to_end = function()
  local path = vim.fn.expand("%:p")
  if path == "" then return end
  cmd("$argadd " .. vim.fn.fnameescape(path))
  cmd("argdedupe")
  M.show_argslist()
end

M.replace_arg_at_idx = function(idx)
  local path = vim.fn.expand("%:p")
  if path == "" then return end
  local argc = vim.fn.argc()
  if idx > argc then
    M.add_buffer_to_end()
    return
  end
  cmd(idx .. "argdelete")
  cmd(idx-1 .. "argadd " .. vim.fn.fnameescape(path))
  cmd(idx .. "argument")
  M.show_argslist()
end

M.save_args = function()
  local args = vim.fn.argv()
  if #args == 0 then return print("Nothing to save") end

  local path = vim.fn.stdpath("data") .. "/argslist/"
  vim.fn.mkdir(path, "p")
  local file = path .. vim.fn.sha256(vim.fn.getcwd()):sub(1, 6) .. ".txt"

  local f = io.open(file, "w")
  if f then
    for _, arg in ipairs(args) do f:write(arg .. "\n") end
    f:close()
    print("Saved: " .. file)
  end
end

M.load_args = function()
  local file = vim.fn.stdpath("data") .. "/argslist/" .. vim.fn.sha256(vim.fn.getcwd()):sub(1, 6) .. ".txt"
  if not vim.uv.fs_stat(file) then return print("No saved list") end

  local lines = {}
  for line in io.lines(file) do table.insert(lines, vim.fn.fnameescape(line)) end
  cmd("args " .. table.concat(lines, " "))
  M.show_argslist()
end

M.delete_arg = function()
  cmd("argdelete %")
  cmd("b#")
  M.show_argslist()
end

M.delete_all = function()
  cmd("argdelete *")
  cmd("b#")
  M.show_argslist()
end

M.show_argslist = function()
  local args = vim.fn.argv()
  local cur_buf = vim.fn.expand("%:t") -- current buffer name
  local parts = {}

  -- Build args list
  for i, f in ipairs(args) do
    local name = vim.fn.fnamemodify(f, ":t")
    local label = i .. ":" .. name

    if vim.fn.fnamemodify(f, ":t") == cur_buf then
      table.insert(parts, "%#IncSearch#[" .. label .. "]")  -- highlight current
    else
      table.insert(parts, "%#TabLine#" .. label)
    end

    table.insert(parts, " ")
  end

  -- Show current buffer separately if it’s not in args
  local in_args = false

  for _, f in ipairs(args) do
    if vim.fn.fnamemodify(f, ":t") == cur_buf then
      in_args = true
      break
    end
  end

  if not in_args and cur_buf ~= "" then
    table.insert(parts, "%#TermCursor# " .. cur_buf .. " ")
  end

  vim.wo.winbar = table.concat(parts) .. "%#TabLine#%=%<"
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "BufAdd" }, {
  callback = function() require("argslist").show_argslist() end,
})

return M
