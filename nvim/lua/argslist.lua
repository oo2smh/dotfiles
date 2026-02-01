local M = {}

M.echo_argslist = function()
  local args = vim.fn.argv()
  if #args == 0 then
    api.nvim_echo({ { "[]", "Comment" } }, false, {})
    return
  end

  local formatted = {}
  for i, f in ipairs(args) do
    local name = vim.fn.fnamemodify(f, ":t")
    name = name == "" and "[ ]" or name
    local label = i .. ":" .. (name:sub(1, 8))
    table.insert(formatted, label)
  end

  api.nvim_echo({ { table.concat(formatted, "  "), "Identifier" } }, false, {})
end

M.add_buffer_to_end = function()
  local path = vim.fn.expand("%:p")
  if path == "" then return end
  cmd("$argadd " .. vim.fn.fnameescape(path))
  cmd("argdedupe")
  M.echo_argslist()
end

M.replace_arg_at_idx = function(idx)
  local path = vim.fn.expand("%:p")
  if path == "" then return end
  if vim.fn.argc() < idx then
    M.add_buffer_to_end()
  else
    cmd(idx .. "argadd " .. vim.fn.fnameescape(path))
    cmd((idx + 1) .. "argdelete")
    M.echo_argslist()
  end
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
  M.echo_argslist()
end

return M
