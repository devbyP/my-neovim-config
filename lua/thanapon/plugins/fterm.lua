vim.keymap.set('n', '<leader>t', "<CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set('t', '<leader>t', "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")
vim.keymap.set('n', '<leader>g', '<CMD>lua require("FTerm"):new({ cmd = { "gitui" } }):open()<CR>')

