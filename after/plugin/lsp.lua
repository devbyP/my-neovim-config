local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    "eslint",
    "gopls",
    "tsserver",
    "volar",
    "sumneko_lua",
    "rust_analyzer",
    "clangd",
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})


--[[
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
]] --

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
    map('n', 'K', vim.lsp.buf.hover, bufopts)
    map('n', 'gi', vim.lsp.buf.implementation, bufopts)
    map('n', '<C-h>', vim.lsp.buf.signature_help, bufopts)
    map('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    map('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    map('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- map('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    map('n', 'gr', vim.lsp.buf.references, bufopts)
    map('n', '<leader>fm', function() vim.lsp.buf.format { async = true } end, bufopts)
end

lsp.on_attach(function(_, bufnr)
    -- fmt_on_save(client, bufnr)
    key_mapping(bufnr)
end)

lsp.setup()