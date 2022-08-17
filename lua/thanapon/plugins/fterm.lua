vim.keymap.set('n', '<leader>t', "<CMD>lua require('FTerm').open()<CR>")
vim.keymap.set('t', '<ESC>', "<C-\\><C-n><CMD>lua require('FTerm').close()<CR>")
vim.keymap.set('n', '<leader>g', '<CMD>lua require("FTerm"):new({ cmd = { "gitui" } }):open()<CR>')

