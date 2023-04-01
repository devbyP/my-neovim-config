vim.keymap.set('n', '<leader>t', "<CMD>lua require('FTerm').open()<CR>")
vim.keymap.set('t', '<ESC>', "<C-\\><C-n><CMD>lua require('FTerm').close()<CR>")

