-- undo auto pairs for md
keymap('i', "'", "'", { buffer = 0 })
keymap('i', "\"", "\"", { buffer = 0 })

vim.fn.setreg("x", 'V:s/\v\\*//ge\r_wi*A*gUU')
vim.fn.setreg("u", 'mx:g/^## /normal @x\r\'x')

-- vim.fn.setreg("u", '0:s/\\*//ge\rVUgI*\<Esc>A*\<Esc>')
-- [[ and ]] to navigate between sections
-- [s and ]s to navigate between spellwords
