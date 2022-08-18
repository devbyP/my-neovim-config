return require('packer').startup(function()

  ----------------------------------------------
  -- Packer Package Manager to manage it self --
  ----------------------------------------------
  use 'wbthomason/packer.nvim'

  -- Dependency for other plugins
  use "nvim-lua/plenary.nvim"

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
  use({
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('thanapon.plugins.nvim-tree')
    end
  })

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

  -- Better syntax highlight --
  use({
    {
      'nvim-treesitter/nvim-treesitter',
      event = 'CursorHold',
      run = ':TSUpdate',
      config = function()
        require('thanapon.plugins.treesitter')
      end
    },
    { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
  })

  -- LSP Config, Snippet, and Completion --

  -- Completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Snippet engine
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('thanapon.plugins.lsp.null-ls')
    end
  })

end)

