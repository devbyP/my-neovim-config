require("nvim-tree").setup({
  open_on_setup = true,
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    side = 'left',
  },
  filters = {
    custom = { '.git$', 'node_modules$' }
  },
  git = {
    ignore = false,
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false,
      }
    }
  },
  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
        folder_arrow = false,
      },
      glyphs = {
        default = '',
        git = {
          unstaged = '~',
          staged = '+',
          unmerged = '!',
          renamed = '≈',
          untracked = '?',
          deleted = '-',
        },
      },
    },
    indent_markers = {
        enable = true,
    },
  }
})

vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<leader>n', ':NvimTreeFocus<CR>', { silent = true })

