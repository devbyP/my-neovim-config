local nvim_lsp = require('lspconfig')
local U = require('thanapon.plugins.lsp.config')

-- setup disagnostic
require("thanapon.plugins.lsp.handlers").setup()
U.disgnostic_key_map_setup()

---Common perf related flags for all the LSP servers
local flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 200,
}

-- Common on_attach
local function on_attach(client, bufnr)
  U.disable_formatting(client)
  U.key_mapping(bufnr)
end

-- Common capabilities
local capabilities = U.capabilities

nvim_lsp.sumneko_lua.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'use' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { os.getenv('VIMRUNTIME') },
      },
    }
  }
})

-- Default setting lsp servers.
local servers = {
  'gopls',
  'tsserver',
  'volar',
}

for _, server in ipairs(servers) do
    nvim_lsp[server].setup({
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

