local keymap = vim.keymap.set
local api = vim.api
local cmd = vim.cmd

local echo_argslist
local add_buffer_to_end
local replace_arg_at_idx
local save_args
local load_args

-- *************************************************************************
-- KEYS
-- *************************************************************************
for i = 1, 6 do
	keymap({ "n", "v" }, "'" .. i, function()
		replace_arg_at_idx(i)
    echo_argslist()
	end)

  -- GO to args: ALT(1-6)
  keymap("n", string.format("<A-%d>", i), function()
    cmd(string.format("argument %d", i))
    echo_argslist()
  end)

end

keymap("n", "hia", function() load_args() end) -- load
keymap("n", "<leader>as", function() save_args() end) -- download
keymap("n", "<leader>ad", ":argdelete %<CR>") -- removes the current file from argslist
keymap("n", "<leader>a*", ":argdelete *<cr>") -- delete all
keymap("n", "<leader>aa", function() add_buffer_to_end() end) -- append
keymap("n", "<leader>ai", function() echo_argslist() end)

-- *************************************************************************
-- HELPER FNS
-- *************************************************************************
-- ZONE: show args list
echo_argslist = function()
	local args = vim.fn.argv()
	if #args == 0 then
		api.nvim_echo({ { "[]", "None" } }, false, {})
		return
	end

	local formatted_args = {}
	for i, f in ipairs(args) do
		local name = vim.fn.fnamemodify(f, ":t:r") -- no extension
		if name == "" then
			name = "[ ]"
		end
		local label = i .. " " .. name

		if #label > 10 then
			label = label:sub(1, 10)
		end

		table.insert(formatted_args, label)
	end

	local result = table.concat(formatted_args, " ")

	api.nvim_echo({ { result, "None" } }, false, {})
end


-- ZONE:BUFFER TO END
-- could not get the more optimal code to run. So this is the more hackish way with a few extra steps.
add_buffer_to_end = function ()
	if bufname_a == "" then
		print("Buffer has no name, cannot add.", vim.log.levels.WARN)
		return
	end

	local argc_before = vim.fn.argc() --returns length
  cmd("$arga")
	cmd("argdedupe")
	local argc_after = vim.fn.argc()

	-- Check if the argument count is the same as before
	if argc_after == argc_before then
		vim.notify("Buffer already exists in the arglist.", vim.log.levels.WARN)
	end
  echo_argslist()
end

-- ZONE: REPLACE ARGS
replace_arg_at_idx = function(idx)
	local argc = vim.fn.argc()

	if argc < idx then
		add_buffer_to_end()
	 	echo_argslist()
		return
	end

  cmd(idx .. "argadd")
	cmd(idx .. "argdelete")
	echo_argslist()
end

-- ZONE: SAVE ARGS
save_args= function()
	local args = vim.fn.argv()

	if #args == 0 then
		print("No args to save.")
		return
	end

	local cwd = vim.fn.getcwd()
	local hash = vim.fn.sha256(cwd):sub(1, 6)
	local path = vim.fn.stdpath("data") .. "/argslist/"

	-- Create directory (with parents) if it doesn't exist
	vim.fn.mkdir(path, "p")
	local file = path .. hash .. ".txt"

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
end

-- ZONE: LOAD ARGS
load_args  = function()
	local hash = vim.fn.sha256(vim.fn.getcwd()):sub(1, 6)
	local file = vim.fn.stdpath("data") .. "/argslist/" .. hash .. ".txt"

	if not vim.loop.fs_stat(file) then
		return print("No saved args for cwd.")
	end

	local args = {}
	for line in io.lines(file) do
		table.insert(args, line)
	end

	-- set the args list and opens first entry of argslist
	vim.cmd("args " .. table.concat(args, " "))
	print("Args loaded: " .. #args .. " file(s) in the args list")
end
