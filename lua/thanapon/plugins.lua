return require('packer').startup(function(use)
    ----------------------------------------------
    -- Packer Package Manager to manage it self --
    ----------------------------------------------
    use 'wbthomason/packer.nvim'

    -- Dependency for other plugins
    use "nvim-lua/plenary.nvim"

    -- Status line
    use({
        'nvim-lualine/lualine.nvim',
    })

    -- Indent line mark --
    use({
        "lukas-reineke/indent-blankline.nvim",
    })

    -- File Explorer manager --
    use({
        'kyazdani42/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    })

    -- Colorscheme --
    use({ 'RRethy/nvim-base16' })

    use({ 'pineapplegiant/spaceduck' })

    use({
        'rose-pine/neovim',
        as = 'rose-pine'
    })

    -- Telescope --
    use({
        'nvim-telescope/telescope.nvim',
        tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    })

    -- Harpoon for file navigation --
    use({
        'thePrimeagen/harpoon',
    })

    -- Undotree for file history --
    use({
        "mbbill/undotree",
    })

    -- Terminal --
    use({
        'numToStr/FTerm.nvim',
        event = 'CursorHold',
    })

    -- Zen Mode --
    use("folke/zen-mode.nvim")
    -- Twilight dim inactive code (use with zen mode) --
    use("folke/twilight.nvim")

    -- Better syntax highlight --
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/nvim-treesitter-context')
    use('p00f/nvim-ts-rainbow', { after = 'nvim-treesitter' })

    -- LSP Config, Snippet, and Completion --
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required

            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            { 'L3MON4D3/LuaSnip' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use('jose-elias-alvarez/null-ls.nvim')

    -- Git Tools --
    use('lewis6991/gitsigns.nvim')
end)
