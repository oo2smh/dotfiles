--------------------------------------
-- CUSTOM ARGUMENT HARPOON
--------------------------------------
local keymap = vim.keymap.set

function EchoArglist()
	local args = vim.fn.argv() -- Get the list of arguments
	if #args == 0 then
		-- If no arguments, display empty brackets
		vim.api.nvim_echo({ { "[]", "None" } }, false, {})
		return
	end

	local formatted_args = {}

	-- Iterate over the arguments and index them manually
	for i, f in ipairs(args) do
		local name = vim.fn.fnamemodify(f, ":t") -- Get the filename part
		local label = i .. " " .. name -- Display index and filename without asterisk
		table.insert(formatted_args, label) -- Insert formatted argument into the table
	end

	-- Echo the formatted arguments, joined by `|`
	vim.api.nvim_echo({ { table.concat(formatted_args, " | "), "None" } }, false, {})
end

-- User command to delete the last argument from the arglist
vim.api.nvim_create_user_command("ArgDeleteLast", function()
	local args = vim.fn.argv()
	if #args < 1 then
		print("Arglist is already empty.")
		return
	end

	local last = args[#args]
	vim.cmd("argdelete " .. vim.fn.fnameescape(last))
	EchoArglist()
end, {})

--HACK: could not get the more optimal code to run. So this is the more hackish way with a few extra steps.
function AddCurrentBufferToArglistEnd()
	local bufname_a = vim.api.nvim_buf_get_name(0)
	local start_idx = vim.fn.argidx() + 1
	local argval = vim.fn.argc()

	if bufname_a == "" then
		print("Buffer has no name, cannot add.", vim.log.levels.WARN)
		return
	end

	if argval == 0 then
		vim.cmd("argadd")
		EchoArglist()
		return
	end

	local argc_before = vim.fn.argc() --returns length

	vim.cmd(":last")
	vim.cmd("argadd " .. vim.fn.fnameescape(bufname_a))
	vim.cmd("argdedupe")
	vim.cmd(":buffer " .. bufname_a)

	local argc_after = vim.fn.argc()

	-- Check if the argument count is the same as before
	if argc_after == argc_before then
		vim.notify("Buffer already exists in the arglist.", vim.log.levels.WARN)
	else
		EchoArglist()
	end
end

local function replace_arg_at_index(idx)
	local bufname = vim.fn.expand("%:p") -- Get the current buffer's full path

	local argc = vim.fn.argc()

	if argc == 0 then
		vim.cmd("argadd " .. bufname)
		EchoArglist()
		return
	end

	if argc < idx then
		AddCurrentBufferToArglistEnd()
		return
	end

	vim.cmd("argument " .. idx)
	vim.cmd("argadd " .. bufname)
	vim.cmd("argdelete")
	vim.cmd("argument " .. idx)
	EchoArglist()
end

-- key: superarg keys
for i = 1, 6 do
	keymap({ "n", "v" }, "<leader>" .. i, function()
		replace_arg_at_index(i)
	end)
end

vim.api.nvim_create_user_command("ArgAddEnd", AddCurrentBufferToArglistEnd, {})
vim.keymap.set("n", "<F12>", EchoArglist, { desc = "Clean and Truncate Argv" })
keymap("n", "<leader>__", ":argdelete *<cr>")
keymap("n", "<F6>", ":ArgDeleteLast<CR>")
keymap("n", "<A-Tab>", "gt")
keymap("n", "<A-1>", ":argument 1<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-2>", ":argument 2<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-3>", ":argument 3<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-4>", ":argument 4<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-5>", ":argument 5<cr>:lua EchoArglist()<cr>")
keymap("n", "<A-6>", ":argument 6<cr>:lua EchoArglist()<cr>")
keymap("n", "<F5>", AddCurrentBufferToArglistEnd, { desc = "Argadd to end" })
