# Philosophy
- Keep it minimal
- Try to use defaults when possible
- Avoid using tabs, built-in-terminal
  - Using both window manager, tmux, and this gets redundant

# Things to Work On
1. Insert mode persistence (<C-o>)
  - try to stay in insert mode to keep flow state
  - `<C-o>` saves you some keystrokes while in insert mode
    - <C-o>ciw: deletes the current word at cursor
    - <C-o>/?(search_pattern): move the cursor then goes to insert mode

> [!NOTE]
> If you must take multiple actions (move cursor + delete selection), enter normal mode.

2. Use of / and ?
  - this feels like a better f/t in that you can search words
3. Standardized use of marks
  - r: reference
  - t: task (currently working on code)
  - h: hub/home, (big-picture engine)
  - m: method/module connected
  - n: notes
  - d: original declaration for fns
  - v: variables
  - s: secondary, smaller task
  - g/w: gotcha, watch-out
4. Standarized use of argslist
  - h: hub biggest file
  - t: task file
  - n: readme notes
  - m: module connected
  - g/w: gotcha file, watch-out file

# Rejected
- kept around just in case, I want to implement these in the future
  - use of quickfix
  - kybd shortcuts for fast nav when using terminal
```lua [QUICKFIX]
-- QUICKFIX
keymap({ "n", "v" }, "<F1>", ":copen<cr>", { silent = true })
keymap({ "n", "v" }, "<F2>", ":cprev<cr>", { silent = true })
keymap({ "n", "v" }, "<F3>", ":cnext<cr>", { silent = true })
keymap("n", "<F4>", function()
  vim.fn.setqflist({}, "r")
end, { desc = "Clear quickfix list" })

-- TERMINAL SPECIFIC
local exit_term = "<C-\\><C-n><ESC>"
keymap("t", "<esc><esc>", exit_term .. ":q<cr>")
keymap("t", "<C-g>", exit_term .. ":bd<cr>", { noremap = true, silent = true })
keymap("t", "<A-.>", exit_term .. ":q<cr>", { noremap = true, silent = true })
keymap("t", "<A-d>", exit_term .. ":vertical resize -20%<CR>", { silent = true })
keymap("t", "<A-left>", exit_term .. ":bp<cr>", { silent = true })
keymap("n", exit_term .. "<A-1>", ":argument 1<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-2>", ":argument 2<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-3>", ":argument 3<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-4>", ":argument 4<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-5>", ":argument 5<cr>:lua EchoArglist()<cr>")
keymap("n", exit_term .. "<A-6>", ":argument 6<cr>:lua EchoArglist()<cr>")

-- AUTOCMDS
-- NOTE: naming conflicts when you try to rename on cwd. to bypass, press :bp to get to rename buffer.
local function dd_removes_qf_item()
  local idx = vim.fn.line(".") - 1
  local qflist = vim.fn.getqflist()
  table.remove(qflist, idx + 1) -- Lua is 1-based
  vim.fn.setqflist(qflist, "r")
  -- Optional: reposition to closest valid entry
  if #qflist > 0 then
    vim.cmd((idx + 1) .. "cfirst")
  end
  vim.cmd("copen")
end

vim.api.nvim_create_user_command("RemoveQFItem", dd_removes_qf_item, {})
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "dd", ":RemoveQFItem<CR>", { buffer = true, silent = true })
  end,
})

```
