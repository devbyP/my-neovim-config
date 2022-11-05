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
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = { os.getenv('VIMRUNTIME') },
      },
    }
  }
})

local function get_typescript_os_path()
  local o = vim.loop.os_uname().sysname
  if o == 'Linux' then
    -- My global node module path on Manjaro Linux using nvm.
    -- This might need to update occationally when update node version.
    return '/home/ttpui/.nvm/versions/node/v18.1.0/lib/node_modules/typescript/lib/tsserverlibrary.js'
  end
  if o == 'Darwin' then
    -- Mac M1(Apple silicon) homebrew.
    return '/opt/homebrew/lib/node_modules/typescript/lib/tsserverlibrary.js'
  end
  return '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'
end

-- volar's config
-- use a local tsserver, and fallback to a global server.
local util = nvim_lsp.util
local function get_typescript_server_path(root_dir)

  -- path to tsserverlibrary
  -- use "npm list -g"
  -- to find where is your node_modules global package live.
  -- replace that path with the part before "node_modules"
  -- local global_ts = '/node_modules/typescript/lib/tsserverlibrary.js'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js'

  -- get path base on my machine.
  local global_ts = get_typescript_os_path()

  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
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
  cmd = { 'vue-language-server', '--stdio' },
  flags = flags,
  capabilities = capabilities,
  on_attach = on_attach,
  -- Takeover mode
  filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  -- tsserver path option.
  root_dir = util.root_pattern('package.json'),
  init_options = {
    languageFeatures = {
      implementation = true,
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = true,
      rename = true,
      renameFileRefactoring = true,
      signatureHelp = true,
      codeAction = true,
      workspaceSymbol = true,
      completion = {
        defaultTagNameCase = 'both',
        defaultAttrNameCase = "kebabCase",
        getDocumentNameCasesRequest = false,
        getDocumentSelectionRequest = false,
      },
      documentHighlight = true,
      documentLink = true,
      codeLens = true,
      diagnostics = true,
    },
    documentFeatures = {
      selectionRange = true,
      foldingRange = true,
      documentSymbol = true,
      documentColor = false,
      documentFormatting = {
        defaultPrintWidth = 100,
        getDocumentPrintWidthRequest = true,
      }
    }
  },
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
})

-- Rust
nvim_lsp.rust_analyzer.setup({
    flags = flags,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
            },
            checkOnSave = {
                allFeatures = true,
                command = 'clippy',
            },
            procMacro = {
                ignored = {
                    ['async-trait'] = { 'async_trait' },
                    ['napi-derive'] = { 'napi' },
                    ['async-recursion'] = { 'async_recursion' },
                },
            },
        },
    },
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

