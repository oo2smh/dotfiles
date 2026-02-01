local function compile_and_run()
  vim.cmd('write')
  local current_file = vim.fn.expand('%')
  local root_file = vim.fn.expand('%:r')
  local compile = 'g++ -o ' .. root_file .. ' ' .. current_file
  local run = './' .. root_file
  local command = 'g++ -std=c++23 -Wall -Wextra -Wconversion -Wsign-conversion -g ' ..
      current_file .. ' -o ' .. root_file .. ' && ./' .. root_file

  -- Execute the combined command in a new terminal buffer
  vim.cmd('sp term://' .. command)
end

keymap("n", "<leader>*", compile_and_run, { silent = true, noremap = true, buffer = true })
