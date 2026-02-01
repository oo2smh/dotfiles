local M = {}
local pick = require("mini.pick")
local fullscreen = false

M.toggle_fullscreen = function()
  if not fullscreen then cmd("wincmd |") cmd("wincmd _") else cmd("wincmd =") end
  fullscreen = not fullscreen
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

------------------------------------------------
-- MINI PICKERS
------------------------------------------------
M.check_health = function()
  local items = vim.fn.getcompletion('checkhealth ', 'cmdline')

  pick.start({
    source = { items = items, name = 'Checkhealth',
      choose = function(item)
        cmd('vert checkhealth ' .. item)
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

return M
