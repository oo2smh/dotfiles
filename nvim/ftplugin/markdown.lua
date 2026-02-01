-- undo auto pairs for md
keymap('i', "'", "'", { buffer = 0 })
keymap('i', "\"", "\"", { buffer = 0 })

-- spellcheck
keymap('n', "lu", "zg" )
keymap("n", "ls", function() o.spell = not vim.opt.spell:get() end, { desc = "Toggle spellcheck" })
vim.fn.setreg("u", '_wi*A*gUU')

-- [[ and ]] to navigate between sections
-- [s and ]s to navigate between spellwords

