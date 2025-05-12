return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup {
      settings = {
        save_on_toggle = true,
      },
    }
    vim.keymap.set('n', '<C-a>', function()
      harpoon:list():add()
    end)
    vim.keymap.set('n', '<C-e>', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    local indexList = { 'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o' }
    for i = 1, 9 do
      vim.keymap.set('n', '<M-' .. indexList[i] .. '>', function()
        harpoon:list():select(i)
      end)
    end
    vim.keymap.set('n', '<M-m>', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<M-,>', function()
      harpoon:list():next()
    end)
  end,
}
