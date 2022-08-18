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

-- volar's config
-- use a local tsserver, and fallback to a global server.
local util = nvim_lsp.util
local function get_typescript_server_path(root_dir)

  -- path to tsserverlibrary
  -- use "npm list -g"
  -- to find where is your node_modules global package live.
  -- replace that path with the part before "node_modules"
  local global_ts = '/opt/homebrew/lib/node_modules/typescript/lib/tsserverlibrary.js'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib', 'tsserverlibrary.js')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

nvim_lsp.volar.setup({
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  -- Takeover mode
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  -- tsserver path option.
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
  end,
})

-- Default setting lsp servers.
local servers = {
  'gopls', -- Golang
  'tsserver', -- Typescript and javascript
  'html', -- HTML
  'cssls', -- Css language server
  'jsonls', -- Json
  'yamlls', -- yaml
  'marksman', -- markdown ls
}

for _, server in ipairs(servers) do
    nvim_lsp[server].setup({
        flags = flags,
        capabilities = capabilities,
        on_attach = on_attach,
    })
end

