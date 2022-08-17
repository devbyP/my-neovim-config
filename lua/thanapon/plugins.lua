return require('packer').startup(function()

  ----------------------------------------------
  -- Packer Package Manager to manage it self --
  ----------------------------------------------
  use 'wbthomason/packer.nvim'

  -- Icon --
  use 'kyazdani42/nvim-web-devicons'

  -- Status line
  use({
    'nvim-lualine/lualine.nvim',
    config = function()
      require('thanapon.plugins.lualine')
    end
  })

  -- File Explorer manager --
  use 'vifm/vifm.vim'
  use({
    'scrooloose/nerdtree',
    config = function()
      require('thanapon.plugins.nerdtree')
    end
  })
  use 'tiagofumo/vim-nerdtree-syntax-highlight'
  use 'ryanoasis/vim-devicons'

  -- Colorscheme --
  use({
    'RRethy/nvim-base16',
    config = function()
      require('thanapon.plugins.nvim-base16')
    end
  })

  -- Terminal --
  use({
    'numToStr/FTerm.nvim',
    event = 'CursorHold',
    config = function()
      require('thanapon.plugins.fterm')
    end
  })

  -- LSP Config --
  use 'neovim/nvim-lspconfig',

end)

