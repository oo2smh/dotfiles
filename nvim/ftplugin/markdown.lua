-- undo auto pairs for md
keymap = vim.keymap.set
keymap('i', "'", "'", { buffer = 0 })
keymap('i', "\"", "\"", { buffer = 0 })
