-- load vim setting options for short typing.
local g = vim.g
local o = vim.o
local opt = vim.opt

-- Decrese update time
o.timeoutlen = 500
o.updatetime = 200

-- Better editor UI
-- Line number
o.number = true
o.numberwidth = 5
o.relativenumber = true
o.signcolumn = 'yes'
o.cursorline = true

-- Better editing experience
-- Indent tab setting
o.expandtab = true
-- o.smarttab = true
-- o.autoindent = true
o.cindent = true
o.tabstop = 4
o.shiftwidth = 0
o.softtabstop = -1 -- use shiftwidth, set to negative
o.wrap = true
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

o.scrolloff = 8

-- Editor line width
o.textwidth = 300

-- Make vim and os clipboard share
o.clipboard = 'unnamedplus'

-- Search casing
o.ignorecase = true
o.smartcase = true

-- Split buffer rules
o.splitright = true
o.splitbelow = true

-- No backup
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false

-- Enable mouse
opt.mouse = 'a'

-- Set leader key to space
g.mapleader = ' '
g.maplocalleader = ' '

g.loaded = 1
g.loaded_netrwPlugin = 1
