return require('packer').startup(function(use)

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

    use({
        'rose-pine/neovim',
        as = 'rose-pine'
    })

    -- File Explorer manager --
    use({
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('thanapon.plugins.nvim-tree')
        end
    })

    -- Colorscheme --
    use({'RRethy/nvim-base16'})

    use({'pineapplegiant/spaceduck'})

    -- Telescope --
    use({
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                          , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('thanapon.plugins.telescope')
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
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use({
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require('thanapon.plugins.lsp.null-ls')
        end
    })

    -- Git Tools --
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
end)

