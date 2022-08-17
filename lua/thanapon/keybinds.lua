-- Easy key bind function
local function map(m, k, a)
  vim.keymap.set(m, k, a, { silent = true })
end

-- Mimic shell movements
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- Easy quit insert mode
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

-- Move to the next/previous buffer
map('n', '<leader>[', ':bp<CR>')
map('n', '<leader>]', ':bn<CR>')

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map('n', '<C-j>', ':move .+1<CR>')
map('n', '<C-k>', ':move .-2<CR>')
map('x', '<C-j>', ":move '>+1<CR>gv=gv")
map('x', '<C-k>', ":move '<-2<CR>gv=gv")

-- Move between window
map('n', '<leader>j', '<C-w>j')
map('n', '<leader>h', '<C-w>h')
map('n', '<leader>k', '<C-w>k')
map('n', '<leader>l', '<C-w>l')

-- Resizing window
-- Resize width hold shift
map('n', '<leader>-', ':vertical resize -5<CR>')
map('n', '<leader>=', ':vertical resize +5<CR>')
-- Resize heigh no shift
map('n', '<leader>_', ':resize -5<CR>')
map('n', '<leader>+', ':resize +5<CR>')

