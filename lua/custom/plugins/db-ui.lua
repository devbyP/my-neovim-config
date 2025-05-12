local vars = require 'custom.vars.db-ui'
local save_location = vars.save_location
return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod', lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = save_location
    vim.g.db_ui_auto_execute_table_helpers = 1

    vim.keymap.set('n', '<leader>db', ':DBUIToggle<CR>', { desc = 'Toggle DBUI' })
    vim.keymap.set('n', '<leader>ndb', ':tabnew<CR>:DBUI<CR>', { desc = 'Open DBUI In New Tab' })
  end,
}
