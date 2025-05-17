local autocmd = vim.api.nvim_create_autocmd
local formatoptions = vim.opt_local.formatoptions

--PREVENT AUTO COMMENTING NEXT LINES
autocmd("FileType", {
	pattern = "*",
	callback = function()
		formatoptions:remove({ "r", "o" })
	end,
})

autocmd("FileType", {
	pattern = "-",
	callback = function()
		formatoptions:remove({ "r", "o" })
	end,
})

-- REMOVE TRAILING WHITESPACE
autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

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
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.keymap.set("n", "dd", ":RemoveQFItem<CR>", { buffer = true, silent = true })
	end,
})
