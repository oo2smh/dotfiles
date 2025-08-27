local keymap = vim.keymap.set
local api = vim.api
local cmd = vim.cmd
local user_cmd = api.nvim_create_user_command

--[[
nvim looks at the folder in which you 1st entered (cwd) when determining which argslist to pull out
:echo getcwd() to view cwd
--]]

-- ^@^ FN IMPLEMENTATION
-- ^:^ show args list
function EchoArglist()
  local args = vim.fn.argv()
  if #args == 0 then
    api.nvim_echo({ { "[]", "None" } }, false, {})
    return
  end

  local formatted_args = {}
  for i, f in ipairs(args) do
    local name = vim.fn.fnamemodify(f, ":t:r") -- no extension
    local label = i .. " " .. name

    if #label > 8 then
      label = label:sub(1, 8)
    end

    table.insert(formatted_args, label)
  end

  local result = table.concat(formatted_args, " ")

  api.nvim_echo({ { result, "None" } }, false, {})
end

-- BUFFER TO END
-- could not get the more optimal code to run. So this is the more hackish way with a few extra steps.
function AddCurrentBufferToArglistEnd()
  local bufname_a = api.nvim_buf_get_name(0)
  local argval = vim.fn.argc()

  if bufname_a == "" then
    print("Buffer has no name, cannot add.", vim.log.levels.WARN)
    return
  end

  if argval == 0 then
    cmd("argadd" .. vim.fn.fnameescape(bufname_a))
    EchoArglist()
    return
  end

  local argc_before = vim.fn.argc() --returns length

  cmd(":last")
  cmd("argadd " .. vim.fn.fnameescape(bufname_a))
  cmd("argdedupe")
  cmd(":buffer " .. bufname_a)

  local argc_after = vim.fn.argc()

  -- Check if the argument count is the same as before
  if argc_after == argc_before then
    vim.notify("Buffer already exists in the arglist.", vim.log.levels.WARN)
  else
    EchoArglist()
  end
end

-- REPLACE ARGS
local function replaceArgsAtIdx(idx)
  local bufname = vim.fn.expand("%:p") -- Get the current buffer's full path

  local argc = vim.fn.argc()

  if argc == 0 then
    cmd("argadd " .. bufname)
    EchoArglist()
    return
  end

  if argc < idx then
    AddCurrentBufferToArglistEnd()
    return
  end

  cmd("argument " .. idx)
  cmd("argadd " .. bufname)
  cmd("argdelete")
  cmd("argument " .. idx)
  EchoArglist()
end

user_cmd("SaveArgs", function()
  local args = vim.fn.argv()
  if #args == 0 then
    print("No args to save.")
    return
  end

  local cwd = vim.fn.getcwd()
  local hash = vim.fn.sha256(cwd):sub(1, 16)
  local dir = vim.fn.stdpath("data") .. "/sarg/" .. hash

  -- Create directory (with parents) if it doesn't exist
  vim.fn.mkdir(dir, "p")

  local file = dir .. "/args.txt"

  -- Delete old file if it exists
  if vim.loop.fs_stat(file) then
    local ok, err = os.remove(file)
    if not ok then
      print("Error deleting old args file: " .. err)
      return
    end
  end

  local f, err = io.open(file, "w")
  if not f then
    print("Error opening file for writing: " .. err)
    return
  end

  for _, arg in ipairs(args) do
    f:write(arg .. "\n")
  end
  f:close()
  print("Args saved to " .. file)
end, {})

-- LOAD ARGS
user_cmd("LoadArgs", function()
  local hash = vim.fn.sha256(vim.fn.getcwd()):sub(1, 16)
  local path = vim.fn.stdpath("data") .. "/sarg/" .. hash
  local files = vim.fn.globpath(path, "*.txt", false, true)
  if vim.tbl_isempty(files) then
    return print("No saved args for cwd.")
  end

  local args = {}
  for line in io.lines(files[1]) do
    table.insert(args, line)
  end

  cmd("args " .. table.concat(args, " "))
  vim.schedule(function()
    if #args > 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(args[1]))
    end
  end)
  print("Args loaded")
end, {})

-- DELETE REMNANT EX FILE
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local cwd = vim.fn.getcwd()
    local hash = vim.fn.sha256(cwd):sub(1, 16)
    local file = vim.fn.stdpath("data") .. "/sarg/" .. hash .. "/args.txt"

    local f = io.open(file, "r")
    if not f then return end

    local args = {}
    for line in f:lines() do
      table.insert(args, line)
    end
    f:close()

    if #args == 0 then return end

    -- Load args list
    vim.cmd("args " .. table.concat(args, " "))

    -- Defer buffer switching and deleting to after startup completes
    vim.defer_fn(function()
      vim.cmd("bp")      -- go to previous buffer
      vim.cmd("bdelete") -- delete the directory buffer
    end, 100)            -- delay in milliseconds
  end,
})

-- KEYS
for i = 1, 6 do
  keymap({ "n", "v" }, "'" .. i, function()
    replaceArgsAtIdx(i)
  end)
end

keymap("n", "<leader>al", "<cmd>LoadArgs<CR>")
keymap("n", "<leader>as", "<cmd>SaveArgs<CR>")

user_cmd("ArgAddEnd", AddCurrentBufferToArglistEnd, {})
keymap("n", "<F12>", EchoArglist, { desc = "Clean and Truncate Argv" })
keymap("n", "<leader>__", ":argdelete *<cr>")
keymap("n", "<F6>", ":argdelete %<CR>")
keymap("n", "<A-Tab>", "gt")

keymap("n", "<A-1>", ":argument 1<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-2>", ":argument 2<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-3>", ":argument 3<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-4>", ":argument 4<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-5>", ":argument 5<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-6>", ":argument 6<cr>:lua EchoArglist()<cr>")
keymap("n", "<F5>", AddCurrentBufferToArglistEnd, { desc = "Argadd to end" })

keymap({ "i", "v" }, "<A-1>", "<ESC>:argument 1<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<A-2>", "<ESC>:argument 2<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<A-3>", "<ESC>:argument 3<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<A-4>", "<ESC>:argument 4<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<A-5>", "<ESC>:argument 5<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<A-6>", "<ESC>:argument 6<cr>:lua EchoArglist()<cr>")
keymap({ "i", "v" }, "<F5>", AddCurrentBufferToArglistEnd, { desc = "Argadd to end" })
