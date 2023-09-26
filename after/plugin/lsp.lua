local lsp = require('lsp-zero')
lsp.preset('recommended')

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "gopls",
        "tsserver",
        "volar",
        "clangd",
        "rust_analyzer",
        "lua_ls"
    },
    handlers = {
        lsp.default_setup,
    },
})

local lua_opts = lsp.nvim_lua_ls()
require('lspconfig').lua_ls.setup(lua_opts)

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
        -- `Enter` key to confirm completion
        ['<CR>'] = cmp.mapping.confirm({select = false}),

        -- Ctrl+Space to trigger completion menu
        ['<C-Space>'] = cmp.mapping.complete(),
    })
})

local fmt_group = vim.api.nvim_create_augroup('FORMATTING', { clear = true })

local fmt_on_save = function(client, buf)
    if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = fmt_group, buffer = buf })
        vim.api.nvim_create_autocmd('BufWritePre', {
            group = fmt_group,
            buffer = buf,
            callback = function()
                vim.lsp.buf.format({ bufnr = buf })
            end,
        })
    end
end

local map = function(m, v, a, opts)
    vim.keymap.set(m, v, a, opts)
end

local key_mapping = function(bufnr)
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }


    map('n', 'gd', vim.lsp.buf.definition, bufopts)
    map('n', 'gD', vim.lsp.buf.declaration, bufopts)
    map('n', '<leader>e', vim.diagnostic.open_float, bufopts)
    map('n', 'd]', vim.diagnostic.goto_next, bufopts)
    map('n', 'd[', vim.diagnostic.goto_prev, bufopts)
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lsp.on_attach(function(client, bufnr)
    -- auto format on save only when using gopls (golang autofomat everytime to follow go idiomatic).
    if client.name == "gopls" then
        fmt_on_save(client, bufnr)
    end
    if client.name == "tsserver" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
    if client.name == "volar" then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
    key_mapping(bufnr)
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
